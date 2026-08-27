# NRV Mobile Worker (Android / Termux)

Этот Worker превращает Android-телефон в постоянно включённый узел NRV-AI-FACTORY.

## Что он делает

- каждые 5 минут проверяет GitHub Issue-очередь NRV-AI-FACTORY;
- ищет открытые задачи с `TASK_ID:` и `STATUS: TODO/IN_PROGRESS/CHANGES_REQUESTED`;
- сохраняет локальное состояние, чтобы не выполнять одну и ту же задачу повторно;
- при наличии настроенного AI CLI передаёт ему задачу;
- после выполнения запускает проверки проекта, если они заявлены;
- коммитит/пушит изменения только в рабочую ветку;
- пишет REPORT обратно в GitHub Issue;
- никогда не force-push main, не трогает secrets и production database.

## Важное ограничение

ChatGPT Plus в Chrome не является API и не может быть вызван из Termux. Worker умеет работать с CLI-агентом, который установлен на телефоне и способен работать без платного API. Если AI CLI не найден, Worker остаётся диспетчером: отслеживает задачи и пишет понятный статус в лог, но сам код не генерирует.

## Установка в Termux

```bash
pkg update -y
pkg install -y git gh nodejs python termux-api
termux-wake-lock
gh auth login
```

Затем:

```bash
cd ~
git clone https://github.com/SHAMKIREC/NRV-AI-FACTORY.git
cd NRV-AI-FACTORY/mobile-worker
chmod +x worker.sh install.sh
./install.sh
./worker.sh
```

## Фоновый режим

`install.sh` создаёт Termux:Boot-скрипт. Для автозапуска после перезагрузки установи приложение Termux:Boot и один раз открой его.

Android: для Termux отключи оптимизацию батареи и разреши работу в фоне. Экран держать включённым не нужно.

## Поддерживаемые AI CLI

Worker ищет исполнителя в таком порядке:

1. `codex`
2. `opencode`
3. команда из переменной `NRV_AGENT_COMMAND`

Если ничего не найдено, задача не помечается выполненной.
