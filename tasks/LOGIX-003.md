# TASK LOGIX-003

TASK_ID: LOGIX-003
PROJECT: LOGIX
TITLE: Аудит доверительной границы API рейсов
OBJECTIVE: Проверить безопасность mutation-path в `api/trips.js` до production SaaS использования и определить минимальный безопасный способ убрать неавторизованные POST/PATCH при сохранении текущего demo-flow.
FILES_TO_INSPECT: api/trips.js; api/_db.js; package.json; vercel.json; существующие auth/session/server helpers, если они есть; клиентские вызовы `/api/trips` только для понимания контракта.
REQUIREMENTS: Сначала установить фактическое наличие/отсутствие auth/authz примитивов; отдельно зафиксировать fixed demo organization behavior; не придумывать авторизацию, если в проекте её нет; предложить минимальный следующий code-step только на основании найденной архитектуры.
DO_NOT_CHANGE: secrets/env; production database/data; API contract без отдельной необходимости; destructive migrations; пользовательский UI; force-push main.
ACCEPTANCE_CRITERIA: Есть точный REPORT с текущей trust boundary POST/PATCH, используемым org scope, фактическими auth/authz checks или их отсутствием, рисками и безопасным следующим этапом; если существующий auth primitive найден — описан конкретный integration point; если не найден — задача не маскируется как production-secure.
TEST_REQUIREMENTS: Для audit-only этапа код не меняется; статическая проверка исходников достаточна. Если после аудита будет создан отдельный code-step, его тесты задаются отдельно.
STATUS: DONE
REVIEW_STATE: APPROVED
CURRENT_PHASE: COMPLETE
NEXT_ACTION: AUTH_STRATEGY_DECISION
