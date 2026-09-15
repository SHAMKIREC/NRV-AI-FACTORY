# PROJECT STATE

| Project | Status | Current task | Last completed | Next action | Blockers |
|---|---|---|---|---|---|
| NRV-DIGITAL | PAUSED | — | NRV-001 partial | — | OWNER_FOCUS_LOGIX_ONLY |
| LOGIX | IN_PROGRESS | LOGIX-004 | BILLING_READINESS + OPS_RUNBOOK + READ_ONLY_NEON_DIAGNOSTICS | BUSINESS_APP_NEXT_SAFE_AUDIT | EXTERNAL_PROVIDERS_AND_APPROVAL_GATES_ONLY |
| DOKMARKET | PAUSED | — | — | — | OWNER_FOCUS_LOGIX_ONLY |
| SAYGO by NRV | PAUSED | SAYGO-002 | — | — | OWNER_FOCUS_LOGIX_ONLY |

## Active owner directive

- Текущий Factory-цикл полностью сфокусирован на **LOGIX / LOGIX-004**.
- Не трогать NRV-DIGITAL, DOKMARKET, SAYGO, RB и другие продуктовые репозитории без нового прямого указания владельца.
- Для LOGIX разрешён полный безопасный цикл: audit → autofix → tests/build → Vercel/Neon verification → live browser QA → regression → report.
- Сохранить developer/demo bypass владельца без обязательной регистрации до отдельного финального решения.
- Не применять destructive DB changes, не удалять пользовательские данные, не менять секреты и не применять Neon production migration без отдельного подтверждения владельца.
- Для production smoke не создавать/не изменять реальные данные без явной необходимости; mutation E2E выполнять только на синтетических тест-данных или изолированной среде.
- GitHub и NRV-AI-FACTORY — источник правил, кода, состояния и доказательств проверки.

## Latest verified evidence

- `LGX-000002` присутствует в production; ИНН обеих сторон разрешаются через `/api/party-suggest`, а live browser QA подтвердил отображение компаний без UI-дефектов.
- Production `/api/health` ранее подтверждён HTTP 200: database=ok, authMode=demo; developer bypass сохранён.
- ИС ЭПД/УКЭП readiness и billing/tariff readiness работают в truthful `not_configured` режиме без фиктивной подписи, отправки, цен, счетов, оплат или автоматических списаний.
- Finance live QA ранее прошёл PASS: 1С, ИС ЭПД/УКЭП и тарификация показывают реальные readiness-состояния.
- Добавлен `docs/OPERATIONS_READINESS.md` с production health triage, incident evidence, backup/restore approval gate и post-recovery verification. Реальный restore или recovery drill не выполнялся.
- Neon read-only diagnostics теперь доступны: `long-running-queries` вернул 0 строк, `locks` вернул 0 строк. `vacuum-stats` прочитан без изменений БД; никаких VACUUM/DDL/write действий не выполнялось.
- Vercel production runtime review за последние 24 часа не показал HTTP failure cluster; записи, классифицированные как error, являются Node `DEP0169 url.parse()` deprecation warnings при успешных HTTP 200 запросах `/api/trips`, `/api/documents`, `/api/party-suggest`. Поиск first-party `url.parse` в LOGIX кода не нашёл, поэтому предупреждение пока рассматривается как dependency/runtime-path issue, а не доказанный дефект LOGIX.
- `LOGIX/TASKS.md` синхронизирован: billing readiness перенесён в DONE, operations/recovery readiness стал текущим безопасным направлением; production recovery drill явно оставлен approval-gated.
- GitHub Actions `LOGIX Quality` для нового documentation/state slice запущен; на момент фиксации состояния run 231 для head `be423ba1ed68d8d648d261a1c496f913dd3fc4d1` ещё pending, поэтому этот slice не помечен Reviewer APPROVED.
- Никаких миграций, destructive DB changes, удаления данных, ротации секретов, restore, mandatory-auth switch или production mutation E2E не выполнялось.

## State rules

- Этот файл — краткий индекс, а не замена TASK/REPORT.
- Состояние обновляется после подтверждённого review.
- Процент готовности не выдумывается без измеримого плана.
- PROJECT_COMPLETE разрешён только после финального аудита Reviewer.
- RB намеренно исключён из Factory и не должен появляться здесь снова без отдельного решения владельца.
