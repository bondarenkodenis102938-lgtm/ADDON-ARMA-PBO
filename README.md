# DU Commander

Standalone Arma 3 addon for Antistasi Ultimate.

## Идея

DU Commander **не создаёт второго AI** и не заменяет High Command Antistasi.

Игрок остаётся своим обычным персонажем. Никаких proxy-unit, selectPlayer, spectator и передачи тела AI.

DU подключается к уже существующим HC-группам Antistasi и даёт игроку командное меню для выбранного AI-лидера.

Схема:

Player
→ DU Commander
→ существующий HC group
→ существующий AI leader
→ штатная Arma / Antistasi AI логика

## Что происходит

1. Ctrl+F10 открывает интерфейс DU.
2. DU получает существующие группы через штатный High Command (hcAllGroups).
3. Игрок выбирает конкретный HC-отряд.
4. DU не меняет лидера, группу, владельца, waypoint brain или поведение Antistasi.
5. Приказ отправляется на машину, где локален настоящий AI-лидер.
6. Сам приказ выполняется штатными Arma командами (commandMove, commandAttack, commandFollow, commandStop, setFormation).
7. Для игрока команда подтверждается через штатное радио.
8. Antistasi продолжает жить своей обычной жизнью.

## Меню

- Выбрать AI-командира
- Движение — сюда
- Атака — на цель
- Стоп
- Следовать за командиром
- Удерживать позицию
- Клин
- Линия
- Колонна

Это намеренно **не отдельный AI brain**. DU только переводит намерение игрока в существующую командную цепочку.

## Почему это ближе к Ultimate

Antistasi Ultimate уже использует High Command и имеет собственные механики AI control/AI possession. В changelog Ultimate отдельно указан High Command Transfer, а AI Possession существует как экспериментальная функция. DU не пытается копировать эти системы, а работает рядом с существующим HC API.

## Сборка

Исходники PBO находятся в addons/DU_Commander.

Собрать через Arma 3 Tools Addon Builder:

- Source: addons/DU_Commander
- Destination: @DU_Commander/addons

Запуск:

-mod=@DU_Commander

## Статус

Prototype: HC Guardian / Radio Relay.

Ключевой принцип: **игрок не превращается в AI и AI не превращается в игрока.**
