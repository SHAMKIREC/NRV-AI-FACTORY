# LOGIX

- Repository: SHAMKIREC/LOGIX
- Status: IN_PROGRESS
- Current task: LOGIX-004 — полный прогон через NRV Center + ECC
- Last completed: LOGIX-003 — аудит доверительной границы API рейсов
- Quality profile: BUSINESS_APP
- Manager: AI Manager
- Developer: ChatGPT / compatible coding agent
- Reviewer: independent review pass

## Фактическое состояние LOGIX-004

LOGIX уже имеет Neon Auth-интеграционный контур, server request context, tenant/role contract и отдельный developer/demo bypass владельца. Production намеренно остаётся в developer/demo режиме: обязательная пользовательская authorization не считается введённой и не включается без отдельного безопасного rollout, сохраняющего доступ владельца.

Миграция 006 для идемпотентности создания рейса применена ранее с явным разрешением владельца. Создание рейса защищено tenant-scoped idempotency contract; complete-trip pagination используется бизнес-потребителями вместо первых 100 записей. Реальные 1С, ИС ЭПД/УКЭП и коммерческий billing остаются readiness-only до появления фактических внешних параметров.

Покрыты desktop/mobile navigation, owner developer bypass, golden trip propagation, mobile drawer reachability/dismissal, loading/error/empty состояния основных workspace owners, production health и operations recovery/access-audit documentation. Recovery drill не выполнялся и не заявляется выполненным.

## Последняя подтверждённая точка — 2026-09-19

- LOGIX Quality #339 завершён SUCCESS на `26a3e1cb72fb1a0529e1e7e4f55781608495165d` (`test(e2e): cover analytics empty and 1c failure states`).
- Workspace state matrix покрывает truthful empty/error states для ЭПД, Водителей, Автопарка, Аналитики, 1С, Уведомлений и Настроек без production mutation.
- Текущий verification candidate: `97b4b5488956dd9750a17090c5520862d653d027` (`test(e2e): verify 1c recovery retry path`). Он расширяет 1С negative-state проверку: после синтетического HTTP 503 кнопка «Повторить» должна реально восстановить readiness UI при успешном повторе, а не только присутствовать визуально.
- Изменение `97b4b548...` затрагивает только Playwright fixture test и не пишет production data.
- Exact-head CI/Vercel verification для `97b4b548...` ещё не зафиксирован; до него commit не считается подтверждённой production точкой.
- Runtime aggregation ранее не показывал application exception cluster; остаётся Node `DEP0169` по `url.parse()`, источник которого не меняется без stack/dependency evidence.
- Developer/demo bypass владельца сохранён; обязательная пользовательская авторизация не включалась.

## Следующий безопасный приоритет

1. Завершить exact-head CI/Vercel/browser verification для `97b4b5488956dd9750a17090c5520862d653d027`; исправлять только воспроизводимый дефект.
2. Продолжить explicit retry/loading/empty/error acceptance для workspace states, где поведение ещё не изолировано fixtures.
3. Продолжить MapLibre-specific loading/performance review без регрессии lazy workspace loading.
4. Консолидировать historical mobile CSS только малыми доказуемыми шагами с regression QA.
5. Добавлять synthetic mutation E2E только без записи production data.
6. Не выполнять recovery restore, destructive DB/data operations, secret rotation или mandatory-auth activation без отдельного разрешения.

## Важное правило

Не считать сведения в этом файле актуальнее фактического состояния целевого репозитория. После каждого серьёзного прохода синхронизировать этот файл с реальным кодом и evidence.
