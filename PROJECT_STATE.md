# PROJECT STATE

| Project | Status | Current task | Last completed | Next action | Blockers |
|---|---|---|---|---|---|
| NRV-DIGITAL | IN_PROGRESS | NRV-001 | — | FULL_AUDIT_AUTOFIX_VERIFY | NONE |
| LOGIX | PAUSED | — | LOGIX-003 | — | OWNER_FOCUS_NRV_ONLY |
| DOKMARKET | PAUSED | — | — | — | OWNER_FOCUS_NRV_ONLY |
| SAYGO by NRV | PAUSED | SAYGO-002 | — | — | OWNER_FOCUS_NRV_ONLY |

## Active owner directive

- Единственный активный продукт сейчас: **NRV-DIGITAL**.
- Factory не начинает и не продолжает работу над LOGIX, DOKMARKET, SAYGO или другими продуктами, пока владелец явно не сменит фокус.
- NRV-001 = полный прогон NRV-DIGITAL через NRV Center + ECC по профилю SHOWCASE_WEB: repository audit → UI/UX audit → autofix → review → live QA → regression → deploy verification.
- Обязательный охват: каждая публичная страница, header/footer, mobile/desktop, typography, spacing, cards, motion, shadows, hover/touch states, links/buttons/forms, accessibility, SEO, performance basics, visual regression и production smoke test.
- Пользовательские скриншоты считаются входом для дефектов и должны быть сопоставлены с live production.
- GitHub и NRV-AI-FACTORY остаются источником правил, кода, состояния и доказательств проверки.

## State rules

- Этот файл — краткий индекс, а не замена TASK/REPORT.
- Состояние обновляется после подтверждённого review.
- Процент готовности не выдумывается без измеримого плана.
- PROJECT_COMPLETE разрешён только после финального аудита Reviewer.
- RB намеренно исключён из Factory и не должен появляться здесь снова без отдельного решения владельца.
