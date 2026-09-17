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

## Current cycle checkpoint — 2026-09-17

- Center inventory/acceptance and real navigation ownership are synchronized with current LOGIX.
- Owner developer/demo bypass remains intact and explicitly covered; it is not represented as completed production user authorization.
- Desktop production smoke opens all connected workspaces through canonical navigation.
- Mobile production smoke verifies Trips → Documents → Counterparties → Finance, persistent drawer access and no document-level horizontal overflow.
- Recoverable negative-state browser coverage exists for Documents, Trips, Directory, Finance and Core; isolated empty-state fixtures cover Documents and Counterparties.
- Golden trip propagation has an explicit regression contract covering creation/status mutation events, Dashboard/global-search refresh, directory derivation from persisted trips + saved INNs, document linkage by trip UUID and the prohibition on mock trip truth.
- Complete-trip pagination is shared by DashboardLiveSummary, global search, Finance and Core (Analytics/1C/Notifications/Settings), removing the known first-100 truncation from business totals and search.
- `src/tripData.js` follows `/api/trips` pagination until the persisted set is complete, rejects invalid pagination and caps client aggregation at 5000 rows pending future server aggregation.
- Regression contracts cover multi-page loading, broken pagination and complete-trip propagation.
- Trip create UI sends a stable `Idempotency-Key`; production migration 006 was applied with owner approval and server-side trip-create idempotency is connected and locked by regression contracts.
- Trip start workflow allows a fully assigned draft to start without exposing the invalid `draft → in_transit` transition error; ordinary status transition protection remains enforced.
- Role visibility/action contract is frozen in `docs/ROLE_MATRIX.md`: Developer owner, Admin, Dispatcher, Accountant and Viewer. Server mutation role guard is implemented for trip/document mutation paths and its developer-bypass/role behavior is locked by tests; mandatory auth remains disabled.
- Current verified LOGIX head: `ed601d0c3739252ff6236625d40aecea5e04cf63` (`test(auth): lock mutation API role enforcement`). GitHub Actions run `35170705989` / #296 completed SUCCESS for that exact head.
- Exact-head Vercel production deployment `dpl_CqX15shBUQhUDz6iis9yW8znBGDa` is READY. Exact deployment `/api/health` returned HTTP 200 with `database: ok`, `authMode: demo` and matching `commitSha: ed601d0c3739252ff6236625d40aecea5e04cf63`, confirming owner developer bypass remains active after the auth-guard commits.
- Vercel runtime error aggregation for the latest hour reports only the known Node DEP0169 `url.parse()` deprecation on API routes; repository code search previously found no direct `url.parse()` source, so no speculative product change was made.
- Live interactive browser QA was attempted through the available browser agent, but that provider rejected strict test mode before a session started; existing production E2E remains the current browser evidence for this checkpoint.
- Historical mobile CSS remains layered: `mobile-production.css` still carries broad `!important` overrides while the later authoritative mobile layer exists. Consolidation remains regression-sensitive and must not be done by blind deletion.
- No destructive DB/data operation, secret rotation, external 1C/EPD transaction or mandatory-auth switch was performed in this cycle.

## Current priority queue

1. Continue audit for any remaining trip consumers that require complete persisted totals; do not replace intentionally paginated list views.
2. Continue explicit loading/empty/error acceptance for every workspace owner.
3. Add isolated/synthetic mutation E2E only when it can avoid persistent production data; do not mutate real production records merely to satisfy a test.
4. Consolidate the historical mobile CSS chain carefully with regression QA; current priority is overlap/density issues visible on narrow mobile screens, while preserving drawer reachability and touch targets.
5. Trace the DEP0169 warning only if dependency/runtime evidence identifies an actionable source; do not rewrite working APIs speculatively.
6. Real 1C, real EPD/УКЭП and commercial billing activation remain blocked on actual provider/operator configuration; do not invent external connectivity.
7. Mandatory user auth remains rollout gated and must retain owner developer access.
