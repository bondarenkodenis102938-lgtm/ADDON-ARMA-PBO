params [
    ["_order", ""],
    ["_payload", []]
];

if (!hasInterface) exitWith {false};
if (!DU_Active) exitWith {false};

private _group = DU_Commander_Group;

if !([_group] call DU_fnc_validateLink) exitWith {
    [] call DU_fnc_close;
    false
};

private _leader = leader _group;
DU_Commander_Leader = _leader;

private _packet = [_group, _order, _payload, player];

if (local _leader) then {
    _packet call DU_fnc_applyOrder;
} else {
    _packet remoteExecCall ["DU_fnc_applyOrder", _leader];
};

true
