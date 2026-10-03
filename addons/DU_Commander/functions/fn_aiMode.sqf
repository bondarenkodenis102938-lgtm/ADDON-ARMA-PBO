if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["DU_Commander_Active", false]) exitWith {};

private _commander = if (!isNull (missionNamespace getVariable ["theBoss", objNull])) then {theBoss} else {player};
private _groups = hcAllGroups _commander;
_groups = _groups select {alive leader _x && {side _x == side _commander}};

if (_groups isEqualTo []) exitWith
{
    hint "DU Commander: у командира сейчас нет доступных HC-отрядов.";
};

missionNamespace setVariable ["DU_Commander_Active", true];
missionNamespace setVariable ["DU_Commander_Group", _groups # 0];

[] call DU_fnc_hcMenu;

hint "DU COMMANDER\n\nИгрок НЕ тронут.\nDU подключён к существующей High Command цепочке Antistasi.\nAI-лидер остаётся AI и продолжает выполнять свою штатную логику.";
