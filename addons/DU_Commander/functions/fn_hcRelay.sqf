if (!hasInterface) exitWith {};
params [
    ["_type", "", [""]],
    ["_pos", [], [[]]],
    ["_target", objNull, [objNull]]
];

private _group = missionNamespace getVariable ["DU_Commander_Group", grpNull];
if (isNull _group) exitWith {hint "DU: HC-отряд не выбран.";};

private _leader = leader _group;
if (isNull _leader || {!alive _leader}) exitWith {hint "DU: лидер HC-отряда недоступен.";};

private _owner = owner _leader;
if (_owner <= 0) exitWith
{
    hint "DU: AI-командир не имеет доступной сетевой локальности.";
};

[_leader, _group, _type, _pos, _target] remoteExecCall ["DU_fnc_hcOrder", _owner, false];

private _msg = switch (_type) do
{
    case "MOVE": {"движение к указанной позиции."};
    case "ATTACK": {"атака по цели."};
    case "STOP": {"стоп."};
    case "FOLLOW": {"следовать за командиром."};
    case "HOLD": {"удерживать позицию."};
    case "WEDGE": {"строй клин."};
    case "LINE": {"строй линия."};
    case "COLUMN": {"строй колонна."};
    default {format ["приказ %1.", _type]};
};

player sideRadio ["DU_HC_ACK", format ["%1, %2", groupId _group, _msg]];
