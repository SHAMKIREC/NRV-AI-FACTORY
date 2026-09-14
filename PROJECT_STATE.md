# PROJECT STATE

| Project | Status | Current task | Last completed | Next action | Blockers |
|---|---|---|---|---|---|
| NRV-DIGITAL | IN_PROGRESS | NRV-001 | — | FULL_AUDIT_AUTOFIX_VERIFY | NONE |
| LOGIX | PAUSED | LOGIX-004 | LOGIX-003 | — | OWNER_FOCUS_NRV_ONLY |
| DOKMARKET | PAUSED | — | — | — | OWNER_FOCUS_NRV_ONLY |
| SAYGO by NRV | PAUSED | SAYGO-002 | — | — | OWNER_FOCUS_NRV_ONLY |

## Active owner directive

- Текущий Factory-цикл полностью сфокусирован на **NRV-DIGITAL / NRV-001**.
- Не трогать LOGIX, DOKMARKET, SAYGO, RB и другие продуктовые репозитории без нового прямого указания владельца.
- Для NRV-DIGITAL разрешён полный безопасный цикл: audit → autofix → visual/UX/motion/accessibility/performance checks → deploy → live browser QA → regression → report.
- Обязателен проход по каждой публичной странице, каждой кнопке/ссылке/форме/меню и mobile+desktop состояниям.
- Исправлять дефекты из пользовательских скриншотов и live production, включая размеры текста/карточек, sticky header overlaps, footer/logo, motion, shadows, spacing, overflow, forms and dead controls.
- GitHub и NRV-AI-FACTORY — источник правил, кода, состояния и доказательств проверки.
- PROJECT_COMPLETE разрешён только после финального Reviewer-аудита и подтверждённого production regression.

## State rules

- Этот файл — краткий индекс, а не замена TASK/REPORT.
- Состояние обновляется после подтверждённого review.
- Процент готовности не выдумывается без измеримого плана.
- PROJECT_COMPLETE разрешён только после финального аудита Reviewer.
- RB намеренно исключён из Factory и не должен появляться здесь снова без отдельного решения владельца.
