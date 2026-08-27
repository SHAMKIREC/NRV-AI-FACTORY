#!/usr/bin/env bash
set -uo pipefail

FACTORY_REPO="SHAMKIREC/NRV-AI-FACTORY"
FACTORY_DIR="$HOME/NRV-AI-FACTORY"
STATE_DIR="$HOME/.nrv-factory"
LOG_FILE="$STATE_DIR/worker.log"
LOCK_FILE="$STATE_DIR/worker.lock"
POLL_SECONDS="${NRV_POLL_SECONDS:-300}"
TASK_TIMEOUT="${NRV_TASK_TIMEOUT:-1200}"
mkdir -p "$STATE_DIR"

log() {
  printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" | tee -a "$LOG_FILE"
}

cleanup() {
  rm -f "$LOCK_FILE"
}

stop_worker() {
  log "Worker остановлен пользователем"
  cleanup
  exit 130
}

trap cleanup EXIT
trap stop_worker INT TERM

if [ -e "$LOCK_FILE" ]; then
  old_pid="$(cat "$LOCK_FILE" 2>/dev/null || true)"
  if [ -n "$old_pid" ] && kill -0 "$old_pid" 2>/dev/null; then
    log "Worker уже запущен: PID $old_pid"
    exit 0
  fi
fi
echo $$ > "$LOCK_FILE"

if ! command -v gh >/dev/null 2>&1; then
  log "ERROR: gh CLI не установлен"
  exit 1
fi
if ! gh auth status >/dev/null 2>&1; then
  log "ERROR: GitHub CLI не авторизован. Выполни: gh auth login"
  exit 1
fi
if ! command -v codex >/dev/null 2>&1; then
  log "ERROR: Codex CLI не установлен"
  exit 1
fi
if ! command -v timeout >/dev/null 2>&1; then
  log "ERROR: команда timeout не найдена (нужен coreutils)"
  exit 1
fi

project_repo() {
  case "$1" in
    LOGIX) echo "SHAMKIREC/LOGIX" ;;
    DOKMARKET) echo "SHAMKIREC/DOKMARKET" ;;
    RB) echo "SHAMKIREC/RB" ;;
    NRV-DIGITAL) echo "SHAMKIREC/NRV-DIGITAL" ;;
    *) echo "" ;;
  esac
}

ensure_repo() {
  repo="$1"
  name="${repo#*/}"
  dir="$HOME/nrv-projects/$name"
  mkdir -p "$HOME/nrv-projects"
  if [ ! -d "$dir/.git" ]; then
    gh repo clone "$repo" "$dir" >>"$LOG_FILE" 2>&1 || return 1
  else
    git -C "$dir" fetch --all --prune >>"$LOG_FILE" 2>&1 || return 1
  fi
  printf '%s' "$dir"
}

extract_field() {
  body="$1"
  key="$2"
  printf '%s\n' "$body" | sed -n "s/^${key}:[[:space:]]*//p" | head -n1
}

post_report() {
  issue="$1"
  body="$2"
  gh issue comment "$issue" --repo "$FACTORY_REPO" --body "$body" >>"$LOG_FILE" 2>&1
}

run_task() {
  issue_number="$1"
  title="$2"
  body="$3"
  task_id="$(extract_field "$body" 'TASK_ID')"
  project="$(extract_field "$body" 'PROJECT')"
  repo="$(project_repo "$project")"
  marker="$STATE_DIR/done-${issue_number}-${task_id}"

  if [ -z "$task_id" ] || [ -z "$project" ]; then
    log "Issue #$issue_number пропущен: нет TASK_ID/PROJECT"
    return 1
  fi
  if [ -e "$marker" ]; then
    return 0
  fi
  if [ -z "$repo" ]; then
    log "$task_id BLOCKED: неизвестный проект $project"
    post_report "$issue_number" "TASK_ID: $task_id\nSTATUS: BLOCKED\nSUMMARY: Mobile Worker не знает GitHub repository для проекта $project.\nFILES_CHANGED: none\nCOMMITS: none\nTESTS: not run\nKNOWN_ISSUES: project mapping missing\nSCREEN_CHECK: not run\nRECOMMENDATION: добавить mapping проекта в mobile-worker/worker.sh"
    touch "$marker"
    return 0
  fi

  workdir="$(ensure_repo "$repo")" || { log "$task_id: не удалось получить $repo"; return 1; }
  branch="factory/${task_id,,}"

  # Worker owns this clone. Clear leftovers from an interrupted attempt before retrying.
  git -C "$workdir" reset --hard HEAD >>"$LOG_FILE" 2>&1 || true
  git -C "$workdir" checkout main >>"$LOG_FILE" 2>&1 || return 1
  git -C "$workdir" pull --ff-only origin main >>"$LOG_FILE" 2>&1 || return 1
  if git -C "$workdir" show-ref --verify --quiet "refs/heads/$branch"; then
    git -C "$workdir" checkout "$branch" >>"$LOG_FILE" 2>&1 || return 1
    git -C "$workdir" reset --hard main >>"$LOG_FILE" 2>&1 || return 1
  else
    git -C "$workdir" checkout -b "$branch" >>"$LOG_FILE" 2>&1 || return 1
  fi

  prompt_file="$STATE_DIR/prompt-${task_id}.txt"
  task_log="$STATE_DIR/task-${task_id}.log"
  : > "$task_log"
  cat > "$prompt_file" <<PROMPT
Ты Developer Agent в NRV-AI-FACTORY.
Выполни только задачу ниже в текущем GitHub-проекте.

$title

$body

Обязательные правила:
- не force-push main;
- не удаляй репозиторий или production database;
- не меняй и не публикуй secrets/env;
- не выполняй destructive migrations;
- не меняй unrelated functionality;
- работай в текущей ветке $branch;
- перед завершением изучи package.json и запускай только существующие проверки, которые доступны локально;
- если безопасно выполнить нельзя, не имитируй успех: создай файл NRV_BLOCKED.md с точной причиной;
- не коммить изменения самостоятельно: Worker сделает commit после проверок.
PROMPT

  log "$task_id: запускаю Codex в $repo (таймаут ${TASK_TIMEOUT}s)"
  set +e
  (
    cd "$workdir" || exit 1
    timeout --signal=INT --kill-after=30s "$TASK_TIMEOUT" \
      codex exec --ephemeral --skip-git-repo-check \
      -s workspace-write -c approval_policy=never -C "$workdir" - \
      < "$prompt_file" 2>&1 | tee -a "$task_log" "$LOG_FILE"
    exit "${PIPESTATUS[0]}"
  )
  agent_rc=$?
  set -u

  if [ "$agent_rc" -eq 124 ] || [ "$agent_rc" -eq 137 ]; then
    log "$task_id: TIMEOUT; Codex остановлен, задача останется активной"
    post_report "$issue_number" "TASK_ID: $task_id\nSTATUS: CHANGES_REQUESTED\nSUMMARY: Mobile Worker остановил зависший запуск Codex по таймауту.\nFILES_CHANGED: none committed\nCOMMITS: none\nTESTS: not run\nKNOWN_ISSUES: Codex timeout; подробности в task-$task_id.log\nSCREEN_CHECK: not run\nRECOMMENDATION: повторить задачу после проверки лога"
    git -C "$workdir" reset --hard HEAD >>"$LOG_FILE" 2>&1 || true
    return 1
  fi

  if [ -f "$workdir/NRV_BLOCKED.md" ]; then
    reason="$(cat "$workdir/NRV_BLOCKED.md")"
    rm -f "$workdir/NRV_BLOCKED.md"
    git -C "$workdir" reset --hard HEAD >>"$LOG_FILE" 2>&1
    post_report "$issue_number" "TASK_ID: $task_id\nSTATUS: BLOCKED\nSUMMARY: $reason\nFILES_CHANGED: none committed\nCOMMITS: none\nTESTS: not run\nKNOWN_ISSUES: blocked by agent\nSCREEN_CHECK: not run\nRECOMMENDATION: требуется решение владельца или новая безопасная задача"
    touch "$marker"
    return 0
  fi

  if [ "$agent_rc" -ne 0 ]; then
    log "$task_id: Codex завершился с кодом $agent_rc; задача останется активной"
    return 1
  fi

  changed="$(git -C "$workdir" status --porcelain)"
  if [ -z "$changed" ]; then
    log "$task_id: агент не внёс изменений"
    return 1
  fi

  tests="not configured"
  test_status="PASS"
  if [ -f "$workdir/package.json" ]; then
    scripts="$(node -e "const p=require('$workdir/package.json'); console.log(Object.keys(p.scripts||{}).join(' '))" 2>/dev/null || true)"
    if printf '%s' "$scripts" | grep -qw test; then
      if (cd "$workdir" && npm test) >>"$LOG_FILE" 2>&1; then tests="npm test: PASS"; else tests="npm test: FAIL"; test_status="FAIL"; fi
    fi
    if printf '%s' "$scripts" | grep -qw build; then
      if (cd "$workdir" && npm run build) >>"$LOG_FILE" 2>&1; then tests="$tests; npm run build: PASS"; else tests="$tests; npm run build: FAIL"; test_status="FAIL"; fi
    fi
  fi

  if [ "$test_status" != "PASS" ]; then
    post_report "$issue_number" "TASK_ID: $task_id\nSTATUS: CHANGES_REQUESTED\nSUMMARY: Агент внёс изменения, но автоматические проверки не прошли. Изменения оставлены только локально в Worker и не запушены.\nFILES_CHANGED: $(git -C "$workdir" status --short | tr '\n' '; ')\nCOMMITS: none\nTESTS: $tests\nKNOWN_ISSUES: см. mobile worker log\nSCREEN_CHECK: not run\nRECOMMENDATION: исправить тесты/build и повторить задачу"
    git -C "$workdir" reset --hard HEAD >>"$LOG_FILE" 2>&1
    return 1
  fi

  git -C "$workdir" add -A
  git -C "$workdir" commit -m "factory: complete $task_id" >>"$LOG_FILE" 2>&1 || return 1
  git -C "$workdir" push -u origin "$branch" >>"$LOG_FILE" 2>&1 || return 1
  commit="$(git -C "$workdir" rev-parse HEAD)"
  files="$(git -C "$workdir" show --name-only --format='' HEAD | paste -sd ', ' -)"

  post_report "$issue_number" "TASK_ID: $task_id\nSTATUS: REVIEW\nSUMMARY: Mobile Worker завершил безопасную реализацию и запушил рабочую ветку.\nFILES_CHANGED: $files\nCOMMITS: $commit\nTESTS: $tests\nKNOWN_ISSUES: требуется Reviewer pass перед merge\nSCREEN_CHECK: not run unless browser agent is connected\nRECOMMENDATION: Reviewer должен проверить diff и acceptance criteria; при APPROVED создать/слить PR и выдать следующую TASK"
  touch "$marker"
  log "$task_id: REPORT отправлен"
  return 0
}

log "NRV Mobile Worker запущен. Интервал: ${POLL_SECONDS}s; таймаут задачи: ${TASK_TIMEOUT}s"
while true; do
  issues_json="$(gh issue list --repo "$FACTORY_REPO" --state open --limit 50 --json number,title,body 2>>"$LOG_FILE" || echo '[]')"
  count="$(printf '%s' "$issues_json" | jq 'length' 2>/dev/null || echo 0)"
  processed=0
  if [ "$count" -gt 0 ]; then
    i=0
    while [ "$i" -lt "$count" ]; do
      item="$(printf '%s' "$issues_json" | jq -c ".[$i]")"
      number="$(printf '%s' "$item" | jq -r '.number')"
      title="$(printf '%s' "$item" | jq -r '.title')"
      body="$(printf '%s' "$item" | jq -r '.body // ""')"
      if printf '%s\n%s' "$title" "$body" | grep -Eq 'TASK_ID:|\[TASK\]'; then
        if printf '%s' "$body" | grep -Eq 'STATUS:[[:space:]]*(TODO|IN_PROGRESS|CHANGES_REQUESTED)'; then
          run_task "$number" "$title" "$body" || true
          processed=1
          break
        fi
      fi
      i=$((i+1))
    done
  fi
  if [ "$processed" -eq 0 ]; then
    log "Активных задач нет"
  fi
  sleep "$POLL_SECONDS"
done
