TASK_ID: SAYGO-001
PROJECT: SAYGO by NRV / SHAMKIREC/saygo-app
TITLE: Основа мобильного курса и первый голосовой урок
OBJECTIVE: Создать честную первую версию приложения: понятное позиционирование, один работающий урок, озвучивание, запись голоса, PWA-основа и проектная документация.
FILES_TO_INSPECT: index.html, manifest.webmanifest, sw.js, README.md
QUALITY_PROFILE: EDUCATION_MOBILE_APP (локальный профиль: frontend + mobile + accessibility + privacy baseline)
TOOLKIT_RULES: Центр NRV; единый цикл проекта; frontend toolkit; security checklist; ECC verification
REQUIREMENTS:
- Бренд: SAYGO by NRV.
- Понятно показать первые 12 бесплатных уроков, 60 уроков в полном курсе и будущую цену 999 ₽.
- Не заявлять, что распознавание речи, платежи или Telegram-проверка уже работают.
- Запись голоса должна происходить только после разрешения микрофона.
- Добавить PRODUCT, DESIGN, ARCHITECTURE, TASKS и SECURITY в проект.
DO_NOT_CHANGE:
- Не добавлять ключи, платежи, Telegram-токены или фиктивную авторизацию.
- Не менять другие репозитории, кроме регистрационной записи и отчёта в Factory.
ACCEPTANCE_CRITERIA:
- Экран читается на телефоне без горизонтального переполнения.
- Озвучивание и запись имеют корректное сообщение об ошибке при отсутствии поддержки.
- PWA-файлы подключены.
- Документация отражает реальное состояние.
TEST_REQUIREMENTS: Проверка файлов, синтаксиса JavaScript, функциональная проверка доступности API в браузере, ручная мобильная визуальная приёмка после публикации.
STATUS: IN_PROGRESS
