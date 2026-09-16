TASK_ID: LOGIX-004
PROJECT: LOGIX
TITLE: Полный прогон LOGIX через NRV Center + ECC
OBJECTIVE: Синхронизировать фактическое состояние LOGIX с Центром, провести FULL AUDIT + AUTOFIX + VERIFY по профилю BUSINESS_APP и закрепить постоянные проектные правила для следующих агентов.
FILES_TO_INSPECT: Определяются по фактической структуре SHAMKIREC/LOGIX; приоритет README.md, docs/, api/, lib/, src/, test/, .github/, package.json, vercel.json.
QUALITY_PROFILE: BUSINESS_APP
TOOLKIT_RULES: docs/CENTER.md; docs/project-cycle.md; docs/quality/QUALITY-GATE.md; docs/security/SECURITY-CHECKLIST.md; docs/frontend-toolkit.md; docs/agents/CLAUDE-MEMORY-AND-RULES.md; NRV-AI-FACTORY/ecc/CODEX-ECC.md.
REQUIREMENTS:
- Не менять другие продуктовые репозитории.
- Проверить architecture/code quality/frontend/backend/auth/API/data isolation/security/forms/mobile/accessibility/performance/dependencies/deployment/regressions.
- Сначала использовать существующие инструменты и зависимости; новые добавлять только при проверяемой пользе.
- Синхронизировать устаревшую документацию production readiness с фактическим кодом.
- Добавить постоянный agent context в LOGIX: CLAUDE.md, PRODUCT.md, DESIGN.md, ARCHITECTURE.md, TASKS.md, SECURITY.md и тематические .claude/rules/ там, где это реально предотвращает повторные ошибки.
- Проверить developer bypass отдельно от будущего user-auth режима; не выдавать demo/dev доступ за production authorization.
- Проверить mobile overflow/overlap/selects/touch targets/navigation и пользовательские сценарии.
- Проверить Vercel deployment/health после изменений.
DO_NOT_CHANGE:
- Не трогать RB, DOKMARKET, NRV-DIGITAL и другие продукты.
- Не удалять production data, базы, secrets или репозитории.
- Не включать обязательный user-auth так, чтобы владелец потерял developer-доступ.
- Не имитировать 1С, ИС ЭПД, УКЭП, платежи или реальные тарифы.
ACCEPTANCE_CRITERIA:
- Factory project state соответствует фактическому состоянию LOGIX.
- Постоянные project/agent rules существуют в LOGIX и отражают реальные команды/архитектуру/ограничения.
- Найденные P0/P1 дефекты исправлены либо явно BLOCKED с причиной.
- npm test и npm run build проходят.
- Production Vercel deployment READY и /api/health отвечает 200.
- Reviewer выполняет отдельный VERIFY pass и фиксирует результат в Factory.
TEST_REQUIREMENTS: npm test; npm run build; API smoke; Vercel deploy check; security negative-case review; mobile/visual review доступными средствами; diff review.
STATUS: IN_PROGRESS

## Current cycle checkpoint — 2026-09-16

- Center inventory/acceptance and real navigation ownership are synchronized with current LOGIX.
- Owner developer/demo bypass remains intact and explicitly covered; it is not represented as completed production user authorization.
- Desktop production smoke opens all connected workspaces through canonical navigation.
- Mobile production smoke verifies Trips → Documents → Counterparties → Finance, persistent drawer access and no document-level horizontal overflow.
- Recoverable negative-state browser coverage exists for Documents, Trips, Directory, Finance and Core; isolated empty-state fixtures cover Documents and Counterparties.
- Golden trip propagation has an explicit regression contract covering creation/status mutation events, Dashboard/global-search refresh, directory derivation from persisted trips + saved INNs, document linkage by trip UUID and the prohibition on mock trip truth.
- Complete-trip pagination is now shared by DashboardLiveSummary, global search, Finance and Core (Analytics/1C/Notifications/Settings), removing the known first-100 truncation from business totals and search.
- `src/tripData.js` follows `/api/trips` pagination until the persisted set is complete, rejects invalid pagination and caps client aggregation at 5000 rows pending future server aggregation.
- Regression contracts cover multi-page loading, broken pagination and complete-trip propagation.
- Trip create UI sends a stable `Idempotency-Key`; production migration 006 was applied with owner approval and server-side trip-create idempotency is connected and locked by regression contracts.
- Trip start workflow allows a fully assigned draft to start without exposing the invalid `draft → in_transit` transition error; ordinary status transition protection remains enforced.
- Current LOGIX implementation head: `e9006cffbb0160c7c6ada3df192df632f2162cf5` (`test(trips): lock idempotent create contract`).
- CI run `35133949863` / #291 is green for that exact head.
- Exact-head Vercel production deployment `dpl_9bUKL8jiJR31CpnieNyx97j9Eooy` is READY.
- Exact-head `/api/health` returned HTTP 200 with `database: ok`, `authMode: demo` and commit SHA `e9006cffbb0160c7c6ada3df192df632f2162cf5` on 2026-09-16.
- Vercel runtime error review over the last 24h found no application exception cluster; the only reported group is Node DEP0169 `url.parse()` deprecation emitted on API routes, to be traced to its dependency/source before changing behavior.
- Historical mobile CSS remains layered: `mobile-production.css` still carries broad `!important` overrides while the later authoritative mobile layer exists. Consolidation remains a regression-sensitive task and must not be done by blind deletion.
- No destructive DB/data operation, secret rotation, external 1C/EPD transaction or mandatory-auth switch was performed in this verification cycle.

## Current priority queue

1. Trace the recurring Node DEP0169 `url.parse()` deprecation to application code or dependency; fix only if source is controlled and change is regression-safe.
2. Continue audit for any remaining trip consumers that require complete persisted totals; do not replace intentionally paginated list views.
3. Continue explicit loading/empty/error acceptance for every workspace owner.
4. Add isolated/synthetic mutation E2E only when it can avoid persistent production data; do not mutate real production records merely to satisfy a test.
5. Consolidate the historical mobile CSS chain carefully with regression QA; current priority is overlap/density issues visible on narrow mobile screens, while preserving drawer reachability and touch targets.
6. Freeze role visibility/action matrix before mandatory auth; preserve developer bypass.
7. Real 1C, real EPD/УКЭП and commercial billing activation remain blocked on actual provider/operator configuration; do not invent external connectivity.
8. Mandatory user auth remains approval/rollout gated and must retain owner developer access.
