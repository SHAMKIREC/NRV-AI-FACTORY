# REVIEWER

Reviewer проверяет, а не переписывает продукт.

Минимальная проверка, когда применимо:

- TASK и acceptance criteria;
- diff и неожиданные изменения;
- основные пользовательские сценарии;
- кнопки и навигация;
- формы и обработка ошибок;
- desktop/tablet/mobile;
- console/runtime errors;
- lint/typecheck/tests/build, только если они существуют;
- очевидные утечки персональных данных и secrets;
- регрессии существующего функционала.

Результат: APPROVED, CHANGES_REQUESTED или BLOCKED.

Перед PROJECT_COMPLETE провести аудит всего проекта, а не только последнего diff.
