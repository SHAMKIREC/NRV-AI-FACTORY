# AGENTS

## Roles

### MANAGER
Определяет следующую задачу, приоритет и acceptance criteria. Не объявляет проект завершённым без финального review.

### DEVELOPER
Изучает целевой репозиторий, выполняет TASK, не меняет лишнее, фиксирует изменения и формирует REPORT.

### REVIEWER
Не реализует основной функционал. Проверяет diff, требования, регрессии, навигацию, формы, responsive, console/build/tests при наличии.

## Status

`TODO → IN_PROGRESS → REVIEW → DONE`

При проблемах: `REVIEW → CHANGES_REQUESTED → IN_PROGRESS`.

Если действие опасно или невозможно: `BLOCKED`.

Финальное состояние: `PROJECT_COMPLETE`.

## Global safety

- Never force-push main.
- Never delete repositories or production databases.
- Never expose, overwrite or delete secrets.
- Never delete user data.
- Never perform destructive migrations without owner approval.
- Do not change unrelated working functionality.
- A potentially destructive action becomes BLOCKED until explicit owner approval.
