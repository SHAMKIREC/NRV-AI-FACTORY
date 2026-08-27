# REPORT PROTOCOL

После каждой задачи Developer публикует:

```text
TASK_ID:
STATUS:
SUMMARY:
FILES_CHANGED:
COMMITS:
TESTS:
KNOWN_ISSUES:
SCREEN_CHECK:
RECOMMENDATION:
```

Нельзя писать DONE, если acceptance criteria фактически не выполнены.

Reviewer после отчёта возвращает одно из:

- `APPROVED` — задача может стать DONE.
- `CHANGES_REQUESTED` — перечислить конкретные исправления.
- `BLOCKED` — указать точную причину.

После APPROVED Manager обновляет состояние и создаёт следующую задачу.
