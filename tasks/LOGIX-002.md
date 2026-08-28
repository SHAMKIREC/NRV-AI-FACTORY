# TASK LOGIX-002

TASK_ID: LOGIX-002
PROJECT: LOGIX
TITLE: Стабилизация навигации Dashboard ↔ Trips
OBJECTIVE: Убрать наиболее хрупкую DOM/querySelector-связку между главным дашбордом и разделом рейсов, сохранив текущий утверждённый внешний вид и функциональность.
FILES_TO_INSPECT: src/main.jsx; src/App.jsx; src/DashboardOps.jsx; src/TripsPortal.jsx; src/DashboardReturnFix.jsx; связанные CSS-файлы только при необходимости.
REQUIREMENTS: Использовать единый React-controlled navigation state/shell для переходов Dashboard ↔ Trips; не открывать разработку новых страниц; не ломать создание/просмотр рейса и возврат на дашборд; минимизировать diff.
DO_NOT_CHANGE: production database; secrets/env; API contract; визуальный дизайн без необходимости; остальные страницы/порталы; force-push main.
ACCEPTANCE_CRITERIA: Переход Dashboard → Trips и Trips → Dashboard работает без поиска кнопок через document.querySelector/button.click; существующий UI и рейсовый flow сохраняются; нет новой страницы или редизайна.
TEST_REQUIREMENTS: npm test; npm run build. Если runtime недоступен — статическая проверка diff и явный REPORT с неисполненными тестами.
STATUS: DONE
REVIEW_STATE: APPROVED
WORK_BRANCH: factory/logix-002-navigation-shell
PULL_REQUEST: SHAMKIREC/LOGIX#1
FINAL_HEAD: 781db9cb9bacac1d6a3d7cbafe2bfe5b47fc7485
MERGE_COMMIT: fcc979bfc51c59bda047b0cb805f332f03d0acdc
CURRENT_PHASE: COMPLETE
NEXT_ACTION: LOGIX-003
