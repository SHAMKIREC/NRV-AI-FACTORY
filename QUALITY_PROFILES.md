# QUALITY PROFILES

Этот файл связывает NRV-AI-FACTORY с NRV-TOOLKIT.

Factory не применяет все правила ко всем задачам. Для каждой задачи выбирается только нужный профиль.

## NRV-DIGITAL

Основной профиль: `SHOWCASE_WEB`

Проверять по необходимости:
- UI и композицию;
- mobile/desktop;
- motion и отсутствие лишних анимаций;
- accessibility;
- SEO;
- performance / Web Vitals;
- broken links / buttons / forms;
- console errors;
- visual regression.

Приоритет TOOLKIT: Design System, Motion, Frontend quality, Accessibility, Performance, SEO, Security basics.

## LOGIX

Основной профиль: `BUSINESS_APP`

Проверять по необходимости:
- бизнес-логику;
- auth / authorization;
- API и trust boundaries;
- данные и разграничение организаций;
- формы и ошибки;
- mobile/desktop;
- accessibility;
- security;
- regression tests;
- документы/ЭДО, если затронуты.

Приоритет TOOLKIT: Product Engineering, Security, Backend, Testing, Accessibility.

Важно: существующий blocker по identity/auth не обходить фиктивным секретом или скрытой авторизацией.

## DOKMARKET

Основной профиль: `MARKETPLACE_APP`

Проверять по необходимости:
- каталог, карточки, поиск и фильтры;
- auth;
- права пользователей;
- документы и загрузки;
- платежную логику, если присутствует;
- персональные данные;
- mobile/desktop;
- accessibility;
- SEO;
- performance;
- security;
- regression tests.

Приоритет TOOLKIT: Product Engineering, Documents, Security, Privacy, Testing, SEO, Frontend quality.

## Исключение

RB не имеет профиля и не должен получать автоматические задачи Factory.

## Как выбирать проверки

- UI-правка: build + visual + mobile + functional + accessibility, performance только если изменение может на него влиять.
- API/backend: build/tests + functional + security + data/auth + regression; visual обычно N/A.
- SEO: build + SEO + links + metadata + performance при необходимости.
- Motion: visual + mobile + accessibility (`prefers-reduced-motion`) + performance.
- Auth/data: security + authorization + negative cases + regression обязательны.

Не устанавливать внешние зависимости только ради галочки. Сначала использовать то, что уже есть в проекте; новое подключать только когда оно реально даёт проверяемую пользу.
