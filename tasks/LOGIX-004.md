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

## Current cycle checkpoint — 2026-09-19

- Center inventory/acceptance and real navigation ownership are synchronized with current LOGIX.
- Owner developer/demo bypass remains intact and explicitly covered; it is not represented as completed production user authorization.
- Desktop production smoke opens all connected workspaces through canonical navigation.
- Mobile production coverage verifies workspace navigation, drawer reachability/dismissal and no document-level horizontal overflow.
- Golden trip propagation has regression coverage across Dashboard, global search, Core, Finance, Directory and Documents.
- Complete-trip pagination is shared by DashboardLiveSummary, global search, Finance, Core, Documents and Directory. `test/allTripConsumersContracts.test.js` now locks the complete persisted trip reader contract and prevents accidental return to first-100 business totals.
- `src/tripData.js` follows `/api/trips` pagination until complete, rejects invalid pagination and caps client aggregation at 5000 rows pending future server aggregation.
- Trip create UI/server idempotency is production-enabled; migration 006 was applied earlier with owner approval and expired-key reuse is covered.
- Trip start workflow supports an assigned draft without exposing the invalid `draft → in_transit` error while ordinary transition protection remains enforced.
- Role visibility/action contract is frozen; developer/demo bypass remains allowed and mandatory auth remains disabled.
- Narrow-mobile navigation is protected by regression tests for viewport reachability, scrolling, z-index ordering, dismissal and trigger accessibility state.
- Driver account groundwork remains tenant-safe; production auth activation stays gated.
- Vercel Hobby deployment remains within the 12 Node function limit.
- Current LOGIX `main` is `4e99846166abd63867ef7bb519c45215e783609e`.
- Exact-head LOGIX Quality run #332 (`35382897990`) completed successfully.
- Exact-head production deployment `dpl_5mbsPwyNVTQ3zmXFh5Mc6y9ZdBAq` is READY and targets production with commit `4e99846166abd63867ef7bb519c45215e783609e`.
- Canonical `https://logix-indol.vercel.app/api/health` returned HTTP 200 with `database=ok`, `authMode=demo` and exact `commitSha=4e99846166abd63867ef7bb519c45215e783609e` on 2026-09-18T20:07Z.
- Runtime error aggregation shows no application exception cluster. The only current group is Node `DEP0169` (`url.parse()` deprecation), seen across API routes; repository inspection still has no evidence of application-owned `url.parse` use, so dependency/stack attribution is required before changing code.
- `CorePortal.jsx` uses `fetchAllTrips()` for Analytics/1C/Notifications and no direct first-100 fetch remains in the audited complete-trip consumers.
- Mobile CSS remains intentionally layered: `mobile-overrides.css` is authoritative last, while `mobile-production.css` still owns non-duplicated workspace sizing/density rules. Wholesale deletion remains unsafe.
- No destructive DB/data operation, secret rotation, external 1C/EPD transaction, billing activation or mandatory-auth switch was performed in this cycle.

## Current priority queue

1. Continue explicit loading/empty/error acceptance for every workspace owner and fix only reproducible gaps.
2. Consolidate historical mobile CSS incrementally with regression QA; preserve drawer reachability, safe areas and touch targets.
3. Add isolated/synthetic mutation E2E only when it cannot persist production data.
4. Trace Node `DEP0169` only when stack/dependency evidence identifies an actionable source; do not guess-rewrite API URL handling.
5. Review MapLibre map loading/performance without regressing lazy loading.
6. Complete backup/restore policy, access-audit procedure and recovery-drill documentation for commercial readiness.
7. Real 1C, real EPD/УКЭП and commercial billing activation remain blocked on actual provider/operator configuration; do not invent external connectivity.
8. Mandatory user auth remains rollout gated and must retain owner developer access.
