# TASK PROTOCOL

Каждая задача должна содержать:

```text
TASK_ID:
PROJECT:
TITLE:
OBJECTIVE:
FILES_TO_INSPECT:
QUALITY_PROFILE:
TOOLKIT_RULES:
REQUIREMENTS:
DO_NOT_CHANGE:
ACCEPTANCE_CRITERIA:
TEST_REQUIREMENTS:
STATUS:
```

## Правила Manager

1. Одна задача должна иметь проверяемый результат.
2. Указывать, что нельзя менять.
3. Не выдумывать пути файлов до первичного осмотра репозитория.
4. Перед работой выбрать профиль из `QUALITY_PROFILES.md`.
5. Указать только те правила NRV-TOOLKIT, которые реально относятся к задаче.
6. Не перегружать задачу всеми проверками подряд: UI-задаче нужны UI/visual/mobile проверки, API-задаче — auth/data/security и т.д.
7. После DONE выбрать следующую задачу исходя из реального состояния проекта, а не старого списка.
8. BLOCKED использовать, когда требуется решение владельца или недоступный ресурс.
9. RB запрещён для автоматического цикла Factory.
