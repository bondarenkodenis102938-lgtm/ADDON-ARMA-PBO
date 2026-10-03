if (!hasInterface) exitWith {};
if !(missionNamespace getVariable ["DU_Commander_Active", false]) exitWith {};

private _commander = player;
private _groups = hcAllGroups _commander;
_groups = _groups select {alive leader _x && {side _x == side _commander}};

if (_groups isEqualTo []) exitWith
{
    hint "DU Commander: у игрока сейчас нет доступных HC-отрядов.";
    [] call DU_fnc_cleanup;
};

private _items = [["DU COMMANDER — выбор существующего HC", true]];

{
    private _g = _x;
    private _leader = leader _g;
    private _label = format ["%1 — %2 (%3)", groupId _g, name _leader, count units _g];

    _items pushBack [
        _label,
        [_forEachIndex + 2],
        "",
        -5,
        [["expression", format [
            "private _g = %1; missionNamespace setVariable ['DU_Commander_Group', _g]; hcSelectGroup [player, _g]; hcShowBar true; showCommandingMenu 'RscMainMenu';",
            _g
        ]]],
        "1",
        "1"
    ];
} forEach _groups;

DU_HC_SELECT = _items;
showCommandingMenu "#USER:DU_HC_SELECT";
