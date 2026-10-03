if (!hasInterface) exitWith {};
if !(missionNamespace getVariable ["DU_Commander_Active", false]) exitWith {};

private _commander = if (!isNull (missionNamespace getVariable ["theBoss", objNull])) then {theBoss} else {player};
private _groups = hcAllGroups _commander;
_groups = _groups select {alive leader _x && {side _x == side _commander}};

if (_groups isEqualTo []) exitWith
{
    hint "DU Commander: HC-отрядов больше нет.";
    [] call DU_fnc_cleanup;
};

private _selectItems = [["DU: ВЫБОР HC-ОТРЯДА", true]];
private _orderItems = [["DU: ПРИКАЗЫ AI-КОМАНДИРУ", true]];

{
    private _g = _x;
    private _leader = leader _g;
    private _label = format ["%1 — %2 (%3)", groupId _g, name _leader, count units _g];
    private _idx = _forEachIndex + 2;

    _selectItems pushBack [
        _label,
        [_idx],
        "",
        -5,
        [["expression", format ["missionNamespace setVariable ['DU_Commander_Group', %1]; hint 'DU: выбран %2';", _g, _label]]],
        "1",
        "1"
    ];
} forEach _groups;

private _g = missionNamespace getVariable ["DU_Commander_Group", grpNull];
private _enabled = {!isNull _g && {alive leader _g}};

_orderItems append [
    ["ДВИЖЕНИЕ — сюда", [2], "", -5, [["expression", "['MOVE', _pos, objNull] call DU_fnc_hcRelay;"]], "1", str _enabled],
    ["АТАКА — на цель", [3], "", -5, [["expression", "['ATTACK', _pos, _target] call DU_fnc_hcRelay;"]], "1", str (_enabled && {!isNull cursorObject})],
    ["СТОП", [4], "", -5, [["expression", "['STOP', getPosATL leader (missionNamespace getVariable ['DU_Commander_Group', grpNull]), objNull] call DU_fnc_hcRelay;"]], "1", str _enabled],
    ["СЛЕДОВАТЬ ЗА МНОЙ", [5], "", -5, [["expression", "['FOLLOW', getPosATL player, objNull] call DU_fnc_hcRelay;"]], "1", str _enabled],
    ["УДЕРЖИВАТЬ ПОЗИЦИЮ", [6], "", -5, [["expression", "['HOLD', getPosATL leader (missionNamespace getVariable ['DU_Commander_Group', grpNull]), objNull] call DU_fnc_hcRelay;"]], "1", str _enabled],
    ["КЛИН", [7], "", -5, [["expression", "['WEDGE', [], objNull] call DU_fnc_hcRelay;"]], "1", str _enabled],
    ["ЛИНИЯ", [8], "", -5, [["expression", "['LINE', [], objNull] call DU_fnc_hcRelay;"]], "1", str _enabled],
    ["КОЛОННА", [9], "", -5, [["expression", "['COLUMN', [], objNull] call DU_fnc_hcRelay;"]], "1", str _enabled]
];

DU_HC_SELECT = _selectItems;
DU_HC_ORDERS = _orderItems;
DU_HC_MAIN = [
    ["DU COMMANDER — существующий Antistasi HC", true],
    ["Выбрать AI-командира", [2], "#USER:DU_HC_SELECT", -5, [["expression", ""]], "1", "1"],
    ["Отдать приказ AI-командиру", [3], "#USER:DU_HC_ORDERS", -5, [["expression", ""]], "1", str _enabled]
];

showCommandingMenu "#USER:DU_HC_MAIN";
