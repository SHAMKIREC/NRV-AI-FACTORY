# PROJECT STATE

| Project | Status | Current task | Last completed | Next action | Blockers |
|---|---|---|---|---|---|
| NRV-DIGITAL | PAUSED | — | NRV-001 partial | — | OWNER_FOCUS_LOGIX_ONLY |
| LOGIX | IN_PROGRESS | LOGIX-004 | EPD_READINESS_BACKEND + CI | VERIFY_BILLING_READINESS_CI_DEPLOY_PRODUCTION | EXTERNAL_PROVIDERS_ONLY |
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
- ИС ЭПД/УКЭП readiness добавлен в существующий `/api/documents` без новой serverless function. Production API отвечает `provider=gis-epd`, `status=not_configured`, `readyForConnection=true`, `connectionTested=false`, `privateKeyStoredInLogix=false`; подпись/юридически значимая отправка выключены.
- Production `/api/health` отвечает HTTP 200: database=ok, authMode=demo; developer bypass сохранён.
- Vercel production deployment для EPD backend находится в READY; production `/api/documents` подтверждает безопасный readiness-контракт.
- Billing/tariff readiness добавлен в существующий tenant-scoped `/api/catalog` без новой Vercel Function и без фиктивных цен/оплат: тарифы, счета, платежи и automatic charges остаются disabled до утверждения commercial terms. Regression contract добавлен; CI/deploy verification выполняется следующим шагом.
- Никаких миграций, destructive DB changes, удаления данных, ротации секретов или mandatory-auth switch не выполнялось.

## State rules

- Этот файл — краткий индекс, а не замена TASK/REPORT.
- Состояние обновляется после подтверждённого review.
- Процент готовности не выдумывается без измеримого плана.
- PROJECT_COMPLETE разрешён только после финального аудита Reviewer.
- RB намеренно исключён из Factory и не должен появляться здесь снова без отдельного решения владельца.
