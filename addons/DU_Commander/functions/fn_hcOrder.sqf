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
private _args = [_leader, _group, _type, _pos, _target];

if (_owner <= 0) exitWith
{
    hint "DU: AI-командир сейчас не локален клиенту, а сервер не сообщил owner.";
};

[_args] remoteExecCall ["DU_fnc_hcOrder", _owner, false];

if (_type isEqualTo "MOVE") then
{
    player sideRadio ["DU_HC_ACK", format ["%1, движение к указанной позиции.", groupId _group]];
}
else
{
    player sideRadio ["DU_HC_ACK", format ["%1, приказ %2.", groupId _group, _type]];
};
