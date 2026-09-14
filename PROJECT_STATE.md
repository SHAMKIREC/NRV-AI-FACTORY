# PROJECT STATE

| Project | Status | Current task | Last completed | Next action | Blockers |
|---|---|---|---|---|---|
| NRV-DIGITAL | IN_PROGRESS | NRV-001 | — | FULL_AUDIT_AUTOFIX_VERIFY | NONE |
| LOGIX | IN_PROGRESS | LOGIX-004 | LOGIX-003 | BUSINESS_APP_SAFE_AUTOFIX_VERIFY | EXTERNAL_INTEGRATIONS_OWNER_INPUT_LATER |
| DOKMARKET | PAUSED | — | — | — | OWNER_FOCUS_NRV_ONLY |
| SAYGO by NRV | PAUSED | SAYGO-002 | — | — | OWNER_FOCUS_NRV_ONLY |

## Active owner directive

- Для текущего Factory-цикла разрешено автономно продолжать **LOGIX** по `LOGIX-004` вместе с NRV-AI-FACTORY state/report файлами, относящимися к LOGIX.
- Не трогать другие продуктовые репозитории.
- Для LOGIX разрешены только безопасные non-destructive изменения: audit → autofix → tests/build → Vercel/health → live browser QA → report state.
- Developer/demo bypass владельца сохраняется; обязательный user auth не включать без отдельного решения.
- Не применять Neon migrations, не удалять данные, не ротировать secrets и не выполнять destructive DB actions без явного подтверждения владельца.
- NRV-001 остаётся отдельной задачей NRV-DIGITAL и этим LOGIX-циклом не изменяется.
- GitHub и NRV-AI-FACTORY остаются источником правил, кода, состояния и доказательств проверки.

## State rules

- Этот файл — краткий индекс, а не замена TASK/REPORT.
- Состояние обновляется после подтверждённого review.
- Процент готовности не выдумывается без измеримого плана.
- PROJECT_COMPLETE разрешён только после финального аудита Reviewer.
- RB намеренно исключён из Factory и не должен появляться здесь снова без отдельного решения владельца.
