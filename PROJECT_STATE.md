# PROJECT STATE

| Project | Status | Current task | Last completed | Next action | Blockers |
|---|---|---|---|---|---|
| NRV-DIGITAL | PAUSED | — | NRV-001 partial | — | OWNER_FOCUS_LOGIX_ONLY |
| LOGIX | IN_PROGRESS | LOGIX-004 | INN_PARTY_VERIFICATION + LIVE_QA | CONTINUE_BUSINESS_APP_GATES | EXTERNAL_PROVIDERS_ONLY |
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

- `LGX-000002` присутствует в production и tenant-scoped `/api/trips`.
- ИНН грузоотправителя `7707083893` и грузополучателя `7736207543` успешно разрешаются production endpoint `/api/party-suggest` через DaData.
- Legacy `/api/company-by-inn` безопасно переписывается на общий lookup без добавления 13-й serverless function; Vercel production остаётся в Hobby limit: 12 functions.
- Live browser QA открыл `LGX-000002` без мутаций и подтвердил отображение обеих компаний в карточке рейса, отсутствие overlap/broken controls.
- GitHub Actions `LOGIX Quality` run 217 для head `5eb13de12cc668893e71be2ecb1949c6035a4019` завершён SUCCESS.

## State rules

- Этот файл — краткий индекс, а не замена TASK/REPORT.
- Состояние обновляется после подтверждённого review.
- Процент готовности не выдумывается без измеримого плана.
- PROJECT_COMPLETE разрешён только после финального аудита Reviewer.
- RB намеренно исключён из Factory и не должен появляться здесь снова без отдельного решения владельца.
