# PROJECT STATE

| Project | Status | Current task | Last completed | Next action | Blockers |
|---|---|---|---|---|---|
| NRV-DIGITAL | PAUSED | — | NRV-001 partial | — | OWNER_FOCUS_LOGIX_ONLY |
| LOGIX | IN_PROGRESS | LOGIX-004 | BILLING_READINESS_UI + CI + DEPLOY + LIVE_QA | BUSINESS_APP_NEXT_SAFE_AUDIT | EXTERNAL_PROVIDERS_ONLY |
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
- Billing/tariff readiness работает через существующий tenant-scoped `/api/catalog` без новой Vercel Function. Production API подтверждает `status=not_configured`, `readyForConnection=true`, provider/pricing unset, `tripTariffs=false`, `invoices=false`, `payments=false`, `automaticCharges=false`, `commercialTermsApproved=false`; фиктивные цены и движение денег не включены.
- Finance UI читает `billingReadiness` из `/api/catalog` и показывает честные статусы внешних контуров вместо фиктивной оплаты. GitHub Actions `LOGIX Quality` для commit `8b9a49e0984f8115ea85d44dc5bed83477d33109` завершён `success`; Vercel commit status также `success`.
- Live browser QA Finance прошёл PASS без мутаций: developer/demo bypass доступен без регистрации; видны `1С — Не подключена`, `ИС ЭПД / УКЭП — Оператор не подключён`, `Тарификация — Тарифная модель не настроена`; вкладки `Рейсы`, `Без тарифа`, `Счета` открываются, фиктивных цен/оплат/кнопок оплаты не обнаружено, layout остаётся рабочим.
- Neon project `LOGIX` обнаружен как `orange-wildflower-06249962`; никаких миграций или write-операций в Neon не выполнялось. Диагностический inspect в этом цикле не использован из-за connector authorization mismatch, что не влияет на production health, подтверждённый приложением.
- Никаких миграций, destructive DB changes, удаления данных, ротации секретов или mandatory-auth switch не выполнялось.

## State rules

- Этот файл — краткий индекс, а не замена TASK/REPORT.
- Состояние обновляется после подтверждённого review.
- Процент готовности не выдумывается без измеримого плана.
- PROJECT_COMPLETE разрешён только после финального аудита Reviewer.
- RB намеренно исключён из Factory и не должен появляться здесь снова без отдельного решения владельца.
