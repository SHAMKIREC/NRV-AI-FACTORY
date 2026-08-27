# NRV AI FACTORY

Бесплатный управляющий репозиторий для совместной работы AI-агентов над проектами NRV.

## Идея

GitHub является общей памятью. Manager ставит задачу, Developer выполняет работу в целевом репозитории, Reviewer проверяет результат. Состояние сохраняется в задачах, отчётах и PROJECT_STATE.md.

## Цикл

`MANAGER → TASK → DEVELOPER → REPORT → REVIEWER → DONE/CHANGES_REQUESTED → NEXT TASK`

Цикл заканчивается только после финального аудита и статуса `PROJECT_COMPLETE`.

## Поддерживаемые проекты

- LOGIX
- DOKMARKET
- RB
- NRV-DIGITAL

Исходный код проектов сюда не копируется. Этот репозиторий хранит только правила, состояние, задачи и отчёты.

## Как начать проект

1. Добавить или обновить `projects/<PROJECT>.md`.
2. Manager создаёт первую задачу по `TASK_PROTOCOL.md`.
3. Developer меняет только целевой репозиторий и публикует отчёт по `REPORT_PROTOCOL.md`.
4. Reviewer проверяет acceptance criteria и регрессии.
5. Manager обновляет `PROJECT_STATE.md` и выдаёт следующую задачу.

## Безопасность

Запрещены force-push в main, удаление production database/repository, публикация или изменение secrets и разрушительные действия без явного подтверждения владельца.

## Стоимость

Архитектура не требует платного API. Она рассчитана на GitHub и доступных/локальных агентов (ChatGPT, Copilot, Codex, Cline, OpenHands, Ollama) без привязки к одному провайдеру.
