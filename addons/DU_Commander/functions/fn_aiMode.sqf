if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["DU_Commander_Active", false]) exitWith {};

private _commander = player;
private _groups = hcAllGroups _commander;
_groups = _groups select {alive leader _x && {side _x == side _commander}};

if (_groups isEqualTo []) exitWith
{
    hint "DU Commander: у игрока сейчас нет доступных HC-отрядов.";
};

missionNamespace setVariable ["DU_Commander_Active", true];
missionNamespace setVariable ["DU_Commander_Group", _groups # 0];

[] call DU_fnc_hcMenu;

hint "DU COMMANDER

Игрок НЕ заменяется и не передаётся AI.
Выбирается существующий Antistasi HC-отряд.
Дальше используются штатные High Command/Commanding Menu.";
