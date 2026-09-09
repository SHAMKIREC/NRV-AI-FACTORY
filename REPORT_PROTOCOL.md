# REPORT PROTOCOL

После каждой задачи Developer публикует:

```text
TASK_ID:
STATUS:
SUMMARY:
FILES_CHANGED:
COMMITS:
TOOLKIT_RULES_APPLIED:
BUILD_CHECK:
FUNCTIONAL_CHECK:
MOBILE_CHECK:
VISUAL_CHECK:
ACCESSIBILITY_CHECK:
PERFORMANCE_CHECK:
SECURITY_CHECK:
REGRESSION_CHECK:
KNOWN_ISSUES:
EVIDENCE:
RECOMMENDATION:
```

Если конкретная проверка к задаче не относится, писать `N/A` и коротко объяснить почему.

Нельзя писать DONE, если acceptance criteria фактически не выполнены или обязательные проверки профиля не пройдены.

Reviewer после отчёта возвращает одно из:

- `APPROVED` — задача может стать DONE.
- `CHANGES_REQUESTED` — перечислить конкретные исправления.
- `BLOCKED` — указать точную причину.

Reviewer обязан проверить не только код, но и доказательства применимых проверок. Если UI можно открыть в preview, одной проверки кода недостаточно.

После APPROVED Manager обновляет состояние и создаёт следующую задачу.
