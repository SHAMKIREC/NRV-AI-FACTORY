REPORT_ID: LOGIX-004
PROJECT: LOGIX
ROLE: REVIEWER
STATUS: IN_PROGRESS
QUALITY_PROFILE: BUSINESS_APP

## Verified evidence

- LOGIX production UI/mobile baseline was live-reviewed on desktop and mobile 390x850; no header overlap, horizontal overflow or DEV-badge blocking was found in the tested scenarios.
- Mobile trip sorting is now an inline React control; the obsolete MutationObserver/querySelector/createPortal enhancer is removed and guarded by regression tests.
- Neon schema has been verified for UUID/FK trip_documents relation and users.auth_user_id -> neon_auth.user mapping.
- Trusted-origin protection is present on trip/document mutations and covered by regression tests.
- Trip number allocation + trip insertion are atomic via one PostgreSQL statement (`WITH next_number AS (...) INSERT INTO trips ... SELECT ...`) from commit `0315b80982b9dea2a116bc4a4f3f5632e453ea52`; `test/tripsAtomicity.test.js` prevents regression.
- Request-context negative coverage verifies fail-closed auth behavior and that browser-supplied organization headers cannot select a tenant.
- Neon Auth session lookup is now bounded to 5 seconds through `fetchWithTimeout`; timeout/provider failure maps to `AUTH_UNAVAILABLE` instead of an unbounded serverless request (`16aff27d8a2c5a3ba0c7f3ebf1677a69c1517ca8`).
- Tenant isolation source contracts were added in `test/tenantIsolationContracts.test.js` and quality run 177 for `3fba6f5010cc13c8ee23307d8f5b5c6b8b28d8db` completed successfully.
- Trip-create idempotency has been designed but deliberately not enabled: migration candidate `docs/migrations/006_trip_create_idempotency.sql` and contract `docs/IDEMPOTENCY.md` exist. No production migration was applied.
- Idempotency schema contract tests were added on main; rollout remains gated by isolated-branch validation and owner approval before any production migration.
- First-user auth bootstrap was changed from separate organization/user inserts to one atomic data-modifying CTE so a failed/racing user insert cannot leave a separately committed orphan organization (`3968f1e0179b91013bd97a7d30d4d9fc3800886f`).
- `test/authBootstrapAtomicity.test.js` guards the atomic bootstrap, trusted-origin requirement and server-side auth-user ownership (`81175afcd61c03a8a8d80bcea4e46fbb28cc379d`).
- Previous reviewed LOGIX main slice `555a3c8e0304492a804be7749a197bb57897faf0` passed GitHub Actions quality run 183, Vercel production deployment, non-destructive live smoke QA and `/api/health`.
- Shared Neon Auth proxy/service requests are now bounded to 5 seconds in `api/_auth-service.js` through `fetchWithTimeout`, covering sign-in, sign-up, sign-out and bootstrap session lookup paths (`e05c86f6b629b744c2c0bba534d8f44e97353bb4`).
- `test/authServiceTimeout.test.js` prevents a raw unbounded auth-provider fetch from returning and confirms all auth entrypoints use the shared bounded service (`311ccd60b235d547d8daaca46ba71835e5ca566f`).
- GitHub Actions `LOGIX Quality` run 185 for `311ccd60b235d547d8daaca46ba71835e5ca566f` completed successfully: dependency install, `npm test` and `npm run build` all passed.
- Vercel production deployment `dpl_3KcCAjhREZgDardnTCAGX4mwjiyT` for `311ccd60b235d547d8daaca46ba71835e5ca566f` is READY.
- Production `/api/health` after that deployment returned HTTP 200 with `ok=true`, `service=logix`, `database=ok`, `authMode=demo`; owner developer bypass remains intact.
- Deployment-scoped Vercel runtime error/fatal logs for the new head were empty in the checked window.
- No production migration, destructive SQL, data deletion, secret rotation or mandatory-auth switch was performed in this slice.
- A server-side 1C readiness endpoint `/api/integration-1c` is live. It exposes only tenant-scoped readiness metadata/counts, reports `not_configured` until real parameters exist, and does not simulate sync or expose credentials. Production response verified HTTP 200 with 1 trip, 5 drivers and 5 vehicles in the current demo tenant.
- Production Playwright smoke was expanded in commit `53c58f5aa554dd2bcb0e207299ab613b75e9bd4b` to cover `dashboard → trips → existing trip → status controls → embedded documents → documents portal` without clicking the status mutation action or writing production data.
- GitHub Actions `LOGIX Quality` run 201 for `53c58f5aa554dd2bcb0e207299ab613b75e9bd4b` completed successfully: `npm test`, `npm run build`, Chromium install and Browser smoke QA all passed.
- Vercel production deployment `dpl_HGRjRsgomDHgN3ubqp8hUomSozaL` for the same E2E commit is READY.
- Production `/api/health` verified HTTP 200 after this cycle with `ok=true`, `database=ok`, `authMode=demo`, preserving owner developer access.
- Vercel runtime review found no new app failure cluster from this slice; the only grouped warning is the existing Node `DEP0169 url.parse()` deprecation seen on `/api/trips` and `/api/documents`, likely from a dependency path and not yet attributed to first-party LOGIX code.
- EPD/UKEP readiness is now implemented server-side inside the existing tenant-scoped `/api/documents` route in commit `497bb5ef33dcac6d993c096abc46bf6e6a4c3304`, avoiding a 13th Vercel function on Hobby. The response exposes only readiness metadata: `provider=gis-epd`, configuration state, `readyForConnection`, `connectionTested`, operator/signature flags, capabilities and `requiredConfiguration`.
- Production `/api/documents` was verified HTTP 200 after the backend deployment and currently reports `status=not_configured`, `readyForConnection=true`, `connectionTested=false`, `operator.configured=false`, `signature.configured=false`, `privateKeyStoredInLogix=false`, `localDrafts=true`, while `legalExchange`, `signing` and `sendToGisEpd` remain false. Required setup currently includes operator, base URL, auth mode, credentials, signature mode and document mapping.
- EPD provider credentials and signing key material remain server-only. `test/epdReadinessContracts.test.js` added in commit `cbe379dffc24eb568520685417ba60241703b88e` asserts that the API does not return token/client-secret values, the frontend does not read EPD secrets, LOGIX does not store the private signing key, and legal exchange/signing remain disabled before a real provider verification.
- `src/DocumentsPortal.jsx` was updated in commit `002f4b073e7df00552d64d5706ef8ef9c25d7517` so the EPD settings panel consumes server readiness instead of relying on a purely static integration state. It is designed to show operator/signature state, safe mode, connection-test state and remaining setup requirements without enabling a fake send/sign action.
- `LOGIX/TASKS.md` was advanced in commit `a28cea18fa54a70dbcc33b5216d34278f22e58ef`: EPD readiness is recorded as completed internal contour work and billing/tariff readiness is now the next safe internal integration task.
- GitHub Actions `LOGIX Quality` run 221 for head `a28cea18fa54a70dbcc33b5216d34278f22e58ef` completed successfully. Dependency install, `npm test`, `npm run build`, Chromium setup and Browser smoke QA all passed.
- Production `/api/health` remains HTTP 200 with `database=ok` and `authMode=demo`, so the owner developer bypass is preserved.
- Vercel deployment `dpl_6HDT8yHAkfqRve76Vi8c6w4471xa` for backend commit `497bb5ef33dcac6d993c096abc46bf6e6a4c3304` is READY and reports 12 Node serverless functions, staying at the Hobby function cap without exceeding it.
- Live non-destructive browser QA of the currently deployed EPD/ETRN settings screen passed visually on narrow/mobile layout: no overlap, clipping or broken controls. Because Vercel has not yet deployed the later frontend readiness commit, this QA is treated only as a regression check of the currently live static panel, not as proof of the new readiness UI.
- GitHub Vercel status for newest head `a28cea18fa54a70dbcc33b5216d34278f22e58ef` currently reports a transient `build-rate-limit` failure. The production alias therefore still points to backend deployment `497bb5...`; the new frontend readiness UI requires an automatic deploy retry followed by exact live QA when the rate limit clears. This is not an owner-action blocker.
- No Neon migration, destructive database mutation, user-data deletion, secret rotation, external-provider credential change or mandatory-auth switch was performed during the EPD readiness cycle.

## Remaining findings

P1 / release boundary:
- Production health still intentionally reports demo/developer auth mode. Developer bypass must remain available to the owner and must not be confused with real user authorization.
- Real user-auth flow and two-tenant isolation must be exercised end-to-end before mandatory production user mode is considered.

P1 / privacy:
- Developer/demo datasets must be synthetic. Any production-like personal data in dev/demo requires a deliberate non-destructive review/sanitization task; no automatic data deletion is allowed.

P2 / backend hardening:
- Trip numbering + trip creation are atomic.
- First-user organization + user bootstrap is atomic.
- Neon Auth provider calls used by both request-context and public auth entrypoints are bounded by timeout.
- Audit-log writes for trip/document business mutations are still non-fatal and outside the main mutation statement; decide later whether audit is compliance-critical enough to make failure block the business mutation.
- Trip-create idempotency design is ready, but migration 006 is not applied. Production enablement requires isolated Neon-branch tests and explicit owner approval before applying the production schema migration.
- Document-create idempotency is partially protected by its existing unique `(organization_id, trip_id, type)` constraint but does not yet expose a general Idempotency-Key contract.
- Address-suggest burst limiting remains instance-local; distributed limiting is needed before public scale.
- Role codes are resolved into request context, but a final business-role permission matrix is not yet frozen; do not invent restrictive RBAC rules that could lock out valid workflows or the owner.

P2 / frontend / QA:
- Non-destructive production smoke now covers existing-trip open, visible status action, embedded documents and transition into the documents portal on desktop, plus mobile shell overflow/overlap. Full mutation E2E (`create trip -> status transition`) remains intentionally excluded until the synthetic test-data strategy is confirmed.
- The EPD readiness frontend code is merged and CI-green, but exact production UI verification must be repeated after Vercel clears the transient build-rate limit and deploys the newest head.
- Mobile/dashboard CSS is still fragmented across multiple override files and should be consolidated with regression QA rather than by blind deletion.

P2 / operations:
- Backup/restore policy, access-audit procedure and recovery drill remain incomplete for commercial production readiness.

P2 / integration completeness:
- 1C readiness contour exists, but real 1C remains unconnected pending concrete endpoint/auth/mapping parameters from the owner or target customer.
- Internal IS EPD/UKEP readiness is now present and truthful; real legal exchange still requires a chosen accredited operator, contract/API parameters, signature mode and mapping. No external integration has been simulated.
- Tariff/payment readiness remains to be prepared without inventing prices or a payment provider.

## Reviewer decision

Current auth hardening, tenant-scope contracts, atomic trip numbering, atomic auth bootstrap, bounded auth-provider access, idempotency design, CI/build, UI/mobile regression, expanded non-destructive trip-detail browser QA, production deployment/health, 1C readiness contour, and server-side EPD/UKEP readiness pass the verified gates above. LOGIX-004 remains IN_PROGRESS. The EPD frontend slice is CI-green but still awaits production deployment because of a transient Vercel build-rate limit; this is an automatic retry item, not an owner blocker. No PROJECT_COMPLETE or 95%-ready claim is allowed yet because real user-auth/two-tenant E2E, data-hygiene confirmation, remaining frontend/operations hardening and several production integrations are still outstanding.

## Next action

Retry the newest LOGIX head deployment after the transient Vercel build-rate limit clears, then run exact live QA of the server-driven EPD settings state. After that, continue with the next safe internal item: billing/tariff readiness without invented prices or payment success states. Keep developer/demo bypass intact and migration 006 prepared-only. Request owner input only when a production schema migration must be applied, destructive/sensitive data action is required, mandatory auth would affect developer access, an external provider must actually be selected/configured, or the product reaches the agreed near-finish threshold.
