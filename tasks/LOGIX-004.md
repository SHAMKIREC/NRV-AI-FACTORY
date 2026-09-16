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

- Center inventory/acceptance and the real navigation ownership are synchronized with current LOGIX.
- Owner developer/demo bypass remains intact and is explicitly covered by tests; it is not represented as completed production user authorization.
- Desktop production smoke opens all connected workspaces through canonical navigation.
- Mobile production smoke verifies Trips → Documents → Counterparties → Finance, persistent drawer access and no document-level horizontal overflow.
- Shared portal selectors are aligned with the actual component ownership (Documents/EPD, directories, Trips/Dispatch, Core sections).
- DirectoryPortal refreshes derived counterparties/driver/fleet data on `logix:trips-changed` and window focus; the contract is regression-tested.
- Non-destructive browser fixtures verify a recoverable Documents API error state and truthful empty states for Documents and Counterparties.
- Golden trip propagation now has an explicit regression contract covering creation/status mutation events, Dashboard/global-search refresh, directory derivation from persisted trips + saved INNs, document linkage by trip UUID and the prohibition on mock trip truth in these workspaces.
- Latest verified LOGIX head: `2c1d1f2d3e714d102e9bd7d3c2d8cd3d6d64e0fc`.
- GitHub Actions `LOGIX Quality` run `35055441861`: SUCCESS.
- Unit/contract suite: 89 passed, 0 failed, 0 skipped.
- Production build: PASS. Known warning remains the separately lazy MapLibre chunk (~920.58 kB minified / ~246.59 kB gzip).
- Exact production gate confirmed `/api/health` reported commit `2c1d1f2d3e714d102e9bd7d3c2d8cd3d6d64e0fc` before browser QA.
- Production Playwright: 6 passed, 6 intentionally skipped by desktop/mobile scope, 0 failed.
- No DB migration, Neon write, destructive change, data deletion, secret rotation, external transaction or mandatory-auth switch was performed.

## Current priority queue

1. Continue loading/empty/error-state acceptance for Trips, Directory, Finance and Core owners using non-destructive browser interception where possible.
2. Add isolated/synthetic mutation E2E only when it can avoid persistent production data; do not mutate real production records merely to satisfy a test.
3. Consolidate the historical mobile CSS chain carefully with regression QA; do not blind-delete overrides.
4. Freeze role visibility/action matrix before mandatory auth; preserve developer bypass.
5. Keep migration 006, real 1C, real EPD/UKЭП, billing commercial activation and mandatory auth approval-gated.
