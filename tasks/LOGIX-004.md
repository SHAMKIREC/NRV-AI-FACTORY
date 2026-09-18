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
- Complete-trip pagination is shared by DashboardLiveSummary, global search, Finance, Core, Documents and Directory. `test/allTripConsumersContracts.test.js` locks the complete persisted trip reader contract and prevents accidental return to first-100 business totals.
- `src/tripData.js` follows `/api/trips` pagination until complete, rejects invalid pagination and caps client aggregation at 5000 rows pending future server aggregation.
- Trip create UI/server idempotency is production-enabled; migration 006 was applied earlier with owner approval and expired-key reuse is covered.
- Trip start workflow supports an assigned draft without exposing the invalid `draft → in_transit` error while ordinary transition protection remains enforced.
- Role visibility/action contract is frozen; developer/demo bypass remains allowed and mandatory auth remains disabled.
- Narrow-mobile navigation is protected by regression tests for viewport reachability, scrolling, z-index ordering, dismissal and trigger accessibility state.
- Driver account groundwork remains tenant-safe; production auth activation stays gated.
- Vercel Hobby deployment remains within the 12 Node function limit.
- Operations readiness now includes a concrete access-audit procedure, backup/restore evidence rules, post-recovery numbering/idempotency checks, truthful RPO/RTO handling, and a commercial-readiness evidence checklist. Recovery drill remains explicitly pending and was not executed.
- Current LOGIX `main` is `614c75230bab18c32d8b32072db2bca4a1007706`.
- Previous exact-head LOGIX Quality run #334 on `dc9133bc52eb95624402062b83c495bbdeb3c52d` completed successfully; run #335 for the current docs-only head is queued.
- Runtime error aggregation previously showed no application exception cluster. The only tracked group is Node `DEP0169` (`url.parse()` deprecation); repository inspection has no evidence of application-owned `url.parse` use, so dependency/stack attribution is required before changing code.
- `CorePortal.jsx` uses `fetchAllTrips()` for Analytics/1C/Notifications and no direct first-100 fetch remains in the audited complete-trip consumers.
- `WorkspaceRouter.jsx` lazy-loads `TripsPortal`, so MapLibre is not part of the dashboard shell import path; deeper map-specific performance review remains queued.
- Mobile CSS remains intentionally layered: `mobile-overrides.css` is authoritative last, while `mobile-production.css` still owns non-duplicated workspace sizing/density rules. Wholesale deletion remains unsafe.
- No destructive DB/data operation, secret rotation, external 1C/EPD transaction, billing activation or mandatory-auth switch was performed in this cycle.

## Current priority queue

1. Continue explicit loading/empty/error acceptance for every workspace owner and fix only reproducible gaps.
2. Consolidate historical mobile CSS incrementally with regression QA; preserve drawer reachability, safe areas and touch targets.
3. Add isolated/synthetic mutation E2E only when it cannot persist production data.
4. Trace Node `DEP0169` only when stack/dependency evidence identifies an actionable source; do not guess-rewrite API URL handling.
5. Continue MapLibre map-specific loading/performance review without regressing lazy workspace loading.
6. Execute the documented access audit when mandatory-auth rollout rehearsal or commercial-readiness review is authorized; documentation is complete but an audit is not falsely marked executed.
7. Prepare a recovery drill only on an isolated target and only after owner approval; do not restore production automatically.
8. Real 1C, real EPD/УКЭП and commercial billing activation remain blocked on actual provider/operator configuration; do not invent external connectivity.
9. Mandatory user auth remains rollout gated and must retain owner developer access.
