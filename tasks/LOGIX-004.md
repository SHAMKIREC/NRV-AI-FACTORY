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

## Current cycle checkpoint — 2026-09-20

- Center inventory/acceptance and real navigation ownership are synchronized with current LOGIX.
- Owner developer/demo bypass remains intact and explicitly covered; it is not represented as completed production user authorization.
- Desktop production smoke opens all connected workspaces through canonical navigation.
- Mobile production coverage traverses every connected workspace, verifies rendering and horizontal-overflow safety, and keeps canonical menu navigation reachable.
- Golden trip propagation has regression coverage across Dashboard, global search, Core, Finance, Directory and Documents.
- Complete-trip pagination is shared by DashboardLiveSummary, global search, Finance, Core, Documents and Directory; first-100 business totals are regression-protected.
- Trip create UI/server idempotency is production-enabled; migration 006 was applied earlier with owner approval and expired-key reuse is covered.
- Trip start workflow supports an assigned draft without exposing the invalid `draft → in_transit` error while ordinary transition protection remains enforced.
- Role visibility/action contract is frozen; developer/demo bypass remains allowed and mandatory auth remains disabled.
- Narrow-mobile navigation is protected by regression tests for viewport reachability, scrolling, z-index ordering, dismissal and trigger accessibility state.
- Driver account groundwork remains tenant-safe; production auth activation stays gated.
- Vercel Hobby deployment remains within the 12 Node function limit.
- Operations readiness includes access-audit procedure, backup/restore evidence rules, post-recovery numbering/idempotency checks, truthful RPO/RTO handling and commercial-readiness evidence checklist. Recovery drill remains explicitly pending and was not executed.
- `e2e/workspace-state-matrix.spec.js` covers truthful empty/error/retry behavior for EPD, Drivers/Fleet, Analytics, 1C, Notifications and Settings without production mutation.
- `CorePortal.jsx`, `FinancePortal.jsx`, `DocumentsPortal.jsx` and `DirectoryPortal.jsx` all consume the shared complete-trip reader; no audited business summary is intentionally limited to the first 100 trips.
- `TripsPortal.jsx` is workspace-lazy but still statically imports MapLibre inside the Trips chunk. This is a performance opportunity, not a correctness defect; do not rewrite the map path without bundle/runtime evidence.
- Mobile CSS remains intentionally layered: `mobile-overrides.css` is authoritative last. The current drawer rules explicitly constrain the open sidebar to `100dvh`, make it scrollable, keep nav/footer reachable, and preserve z-index ordering over workspace portals.
- Lazy workspace loading now exposes a polite atomic live-region status for assistive technology; this is an accessibility hardening, not a behavior change.
- Current LOGIX head is `5bbfe80c7fff09d47aff07dc06c676027b75cb59` (`fix(a11y): announce lazy workspace loading`). LOGIX Quality #351 (run 35462209316) completed SUCCESS on this exact head.
- Current cycle re-audited Core complete-trip usage and workspace-state coverage; no new P0/P1 correctness defect justified a speculative production rewrite.
- Fresh direct `/api/health` retrieval could not be established through the available web path in this cycle, so health is not re-claimed without evidence; exact-head workflow remains green.
- No destructive DB/data operation, secret rotation, migration, external 1C/EPD transaction, billing activation or mandatory-auth switch was performed in this cycle.

## Current priority queue

1. Continue explicit loading/empty/error acceptance for any workspace state not yet isolated by fixtures.
2. Consolidate historical mobile CSS only incrementally with regression QA; preserve drawer reachability, safe areas and touch targets.
3. Add isolated/synthetic mutation E2E only when it cannot persist production data.
4. Trace Node `DEP0169` only when stack/dependency evidence identifies an actionable source.
5. Continue MapLibre map-specific loading/performance review without regressing lazy workspace loading.
6. Execute the documented access audit only when mandatory-auth rollout rehearsal or commercial-readiness review is authorized.
7. Prepare a recovery drill only on an isolated target and only after owner approval; do not restore production automatically.
8. Real 1C, real EPD/УКЭП and commercial billing activation remain blocked on actual provider/operator configuration; do not invent external connectivity.
9. Mandatory user auth remains rollout gated and must retain owner developer access.
