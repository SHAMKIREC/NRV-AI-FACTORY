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

## Current cycle checkpoint — 2026-09-18

- Center inventory/acceptance and real navigation ownership are synchronized with current LOGIX.
- Owner developer/demo bypass remains intact and explicitly covered; it is not represented as completed production user authorization.
- Desktop production smoke opens all connected workspaces through canonical navigation.
- Mobile production smoke verifies Trips → Documents → Counterparties → Finance, persistent drawer access and no document-level horizontal overflow.
- Recoverable negative-state browser coverage exists for Documents, Trips, Directory, Finance and Core; isolated empty-state fixtures cover Documents and Counterparties.
- Golden trip propagation has an explicit regression contract covering creation/status mutation events, Dashboard/global-search/Core/Finance refresh, directory derivation from persisted trips + saved INNs, document linkage by trip UUID and the prohibition on mock trip truth.
- Complete-trip pagination is shared by DashboardLiveSummary, global search, Finance, Core and Documents, removing the known first-100 truncation from business totals, search and document-to-trip selection.
- `src/tripData.js` follows `/api/trips` pagination until the persisted set is complete, rejects invalid pagination and caps client aggregation at 5000 rows pending future server aggregation.
- Trip create UI sends a stable `Idempotency-Key`; production migration 006 was applied with owner approval and server-side trip-create idempotency is connected and locked by regression contracts.
- Trip start workflow allows a fully assigned draft to start without exposing the invalid `draft → in_transit` transition error; ordinary status transition protection remains enforced.
- Role visibility/action contract is frozen in `docs/ROLE_MATRIX.md`; developer/demo bypass remains allowed and mandatory auth remains disabled.
- Narrow-mobile navigation is locked by regression coverage for viewport reachability, scrolling and z-index ordering.
- Driver account groundwork includes tenant-safe user→driver linkage and a dedicated driver-trip API contract; production auth activation remains gated.
- Vercel Hobby function-count regression was recovered by consolidating 1C readiness into `api/catalog.js`; production remains within the 12-function limit.
- Exact-head LOGIX Quality run #327 completed successfully for `666a4174047f18555b8a31af440b72086deed1ca`.
- Production deployment `dpl_DJsUXr5XBZytHnWU6Rk65F9FzVkD` for `666a4174047f18555b8a31af440b72086deed1ca` was READY and targeted production; `/api/health` returned HTTP 200 with `database=ok`, `authMode=demo`.
- Runtime error review for the last 24h showed no application exception cluster; the only grouped signal was Node `DEP0169` (`url.parse()` deprecation). Repository search found no direct `url.parse` use, so it remains dependency/stack investigation rather than a safe source edit.
- Core Analytics/1C/Notifications, Finance and Documents consume `fetchAllTrips()` rather than a first-page trip fetch; no new completeness defect was found in that verification pass.
- Live non-destructive browser QA of the mobile drawer exposed a dismissal/accessibility weakness: Escape did not close the drawer reliably during navigation attempts.
- LOGIX main now includes `237201169acd1382b785cb5c901e85403e172ca8` (`fix(mobile): make drawer dismissible and stateful`): drawer closes on Escape, footer Settings navigation closes it even when already on Settings, and the trigger exposes `aria-expanded`/`aria-controls`.
- Regression contract `ecc123cf9d3a322943e3c327b5ceff2005e93a9e` (`test(mobile): lock drawer dismissal contract`) locks the mobile drawer behavior. LOGIX Quality run #329 is queued/pending for this exact head; production deployment/health must be re-verified after it becomes green.
- No destructive DB/data operation, secret rotation, external 1C/EPD transaction or mandatory-auth switch was performed in this cycle.

## Current priority queue

1. Finish exact-head CI + production deployment/health verification for `ecc123cf9d3a322943e3c327b5ceff2005e93a9e`; fix any regression before continuing.
2. Continue explicit loading/empty/error acceptance for every workspace owner and fix only reproducible gaps.
3. Consolidate the historical mobile CSS chain incrementally with regression QA; prioritize narrow-mobile overlap/density while preserving drawer reachability and touch targets.
4. Continue audit for any remaining trip consumers that require complete persisted totals; do not replace intentionally paginated list views.
5. Add isolated/synthetic mutation E2E only when it can avoid persistent production data; do not mutate real production records merely to satisfy a test.
6. Trace the runtime `DEP0169` warning only when stack/dependency evidence identifies an actionable source.
7. Review MapLibre map-specific loading/performance without regressing lazy loading.
8. Real 1C, real EPD/УКЭП and commercial billing activation remain blocked on actual provider/operator configuration; do not invent external connectivity.
9. Mandatory user auth remains rollout gated and must retain owner developer access.
