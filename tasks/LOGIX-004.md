TASK_ID: LOGIX-004
PROJECT: LOGIX
TITLE: Полный прогон LOGIX через NRV Center + ECC
OBJECTIVE: Синхронизировать фактическое состояние LOGIX с Центром, провести FULL AUDIT + AUTOFIX + VERIFY по профилю BUSINESS_APP и закрепить постоянные проектные правила для следующих агентов.
FILES_TO_INSPECT: Определяются по фактической структуре SHAMKIREC/LOGIX; приоритет README.md, docs/, api/, lib/, src/, test/, .github/, package.json, vercel.json.
QUALITY_PROFILE: BUSINESS_APP
TOOLKIT_RULES: docs/CENTER.md; docs/project-cycle.md; docs/quality/QUALITY-GATE.md; docs/security/SECURITY-CHECKLIST.md; docs/frontend-toolkit.md; docs/agents/CLAUDE-MEMORY-AND-RULES.md; NRV-AI-FACTORY/ecc/CODEX-ECC.md.
REQUIREMENTS:
- Не менять другие продуктовые репозитории.
- Проверить architecture/code quality/frontend/backend/auth/API/data isolation/security/forms/mobile/accessibility/performance/dependencies/deployment/regressions.
- Сначала использовать существующие инструменты и зависимости; новые добавлять только при проверяемой пользе.
- Синхронизировать устаревшую документацию production readiness с фактическим кодом.
- Добавить постоянный agent context в LOGIX: CLAUDE.md, PRODUCT.md, DESIGN.md, ARCHITECTURE.md, TASKS.md, SECURITY.md и тематические .claude/rules/ там, где это реально предотвращает повторные ошибки.
- Проверить developer bypass отдельно от будущего user-auth режима; не выдавать demo/dev доступ за production authorization.
- Проверить mobile overflow/overlap/selects/touch targets/navigation и пользовательские сценарии.
- Проверить Vercel deployment/health после изменений.
DO_NOT_CHANGE:
- Не трогать RB, DOKMARKET, NRV-DIGITAL и другие продукты.
- Не удалять production data, базы, secrets или репозитории.
- Не включать обязательный user-auth так, чтобы владелец потерял developer-доступ.
- Не имитировать 1С, ИС ЭПД, УКЭП, платежи или реальные тарифы.
ACCEPTANCE_CRITERIA:
- Factory project state соответствует фактическому состоянию LOGIX.
- Постоянные project/agent rules существуют в LOGIX и отражают реальные команды/архитектуру/ограничения.
- Найденные P0/P1 дефекты исправлены либо явно BLOCKED с причиной.
- npm test и npm run build проходят.
- Production Vercel deployment READY и /api/health отвечает 200.
- Reviewer выполняет отдельный VERIFY pass и фиксирует результат в Factory.
TEST_REQUIREMENTS: npm test; npm run build; API smoke; Vercel deploy check; security negative-case review; mobile/visual review доступными средствами; diff review.
STATUS: IN_PROGRESS

## Current cycle checkpoint — Center + live verification

- LOGIX Center documentation now defines the product source of truth, ordered execution plan, repository/data-flow inventory and screen acceptance matrix before further implementation work.
- Confirmed P2 mobile navigation defect was fixed: the main LOGIX drawer trigger remains available inside every workspace/portal instead of disappearing outside Dashboard. Developer/demo bypass was preserved.
- Regression coverage now includes the mobile navigation contract and production Playwright coverage for opening the drawer from the Trips portal.
- Production trip-detail browser assertions were aligned with the current resolved-party UI contract without weakening the requirement that company identity/address resolve beyond raw INN fallback.
- Latest verified LOGIX head is `c2dac7c3cb66df57c308eebb192d7e3b5fdb1ad1`.
- GitHub Actions `LOGIX Quality` run `35012569822` completed SUCCESS for that exact head.
- Vercel production deployment `dpl_6rngDdu5jG9gtbUQJknh2Jkk7YWi` is READY for the same exact commit.
- Production `/api/health` returned HTTP 200 with `ok=true`, `database=ok`, `authMode=demo`, and `commitSha=c2dac7c3cb66df57c308eebb192d7e3b5fdb1ad1`; owner developer bypass remains intact.
- Exact-commit CI wait is already present, preventing production browser smoke from silently validating an older Vercel deployment.
- No DB migration, Neon write, destructive change, data deletion, secret rotation, external transaction or mandatory-auth switch was performed.

## Next Center pass

Continue screen-by-screen BUSINESS_APP acceptance from `docs/CENTER_ACCEPTANCE.md`: reproduce current desktop/mobile states, classify P0/P1/P2/P3, fix root causes in dependency order, then require tests/build → matching Vercel commit → non-destructive live QA. Keep migration 006 and real external provider activation approval-gated.
