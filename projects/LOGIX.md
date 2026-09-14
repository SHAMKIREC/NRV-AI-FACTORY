# LOGIX

- Repository: SHAMKIREC/LOGIX
- Status: IN_PROGRESS
- Current task: LOGIX-004 — полный прогон через NRV Center + ECC
- Last completed: LOGIX-003 — аудит доверительной границы API рейсов
- Quality profile: BUSINESS_APP
- Manager: AI Manager
- Developer: ChatGPT / compatible coding agent
- Reviewer: independent review pass

## Фактическое состояние на старте LOGIX-004

Старый blocker `AUTH_PROVIDER_OR_IDENTITY_MODEL` больше не описывает текущее состояние кода. В LOGIX уже добавлены Neon Auth-интеграционный контур, server request context, связь `public.users.auth_user_id -> organization_id/role`, same-origin auth endpoints и отдельный developer/demo bypass для владельца. При этом production сейчас намеренно остаётся в developer/demo режиме, поэтому реальную пользовательскую authorization нельзя считать полностью введённой, пока обязательный auth mode не включён и не пройдены negative-case/E2E проверки.

Также уже выполнены: UUID/FK для `trip_documents.trip_id`, lazy loading тяжёлых разделов, cleanup старых DOM/click interceptors, production health endpoint, lifecycle rules рейсов, server-side validation и часть rate-limit/cache защиты.

## Текущий проход

LOGIX-004 обязан провести FULL AUDIT + AUTOFIX + VERIFY по NRV-TOOLKIT и ECC: architecture, backend/API, auth/data isolation, security, tests, mobile/desktop UX, accessibility, performance, dependencies, deployment и документацию.

## Важное правило

Не считать сведения в этом файле актуальнее фактического состояния целевого репозитория. После каждого серьёзного прохода синхронизировать этот файл с реальным кодом и evidence.
