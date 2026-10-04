params [
    ["_group", grpNull],
    ["_order", ""],
    ["_payload", []],
    ["_requester", objNull]
];

if (isNull _group) exitWith {};

private _leader = leader _group;
if (isNull _leader) exitWith {};
if (!alive _leader) exitWith {};
if (!local _leader) exitWith {};

private _linkedUID = _group getVariable ["DU_LinkOwnerUID", ""];
if (_linkedUID != "") then {
    if (isNull _requester) exitWith {};
    if ((getPlayerUID _requester) != _linkedUID) exitWith {};
};

switch (toUpper _order) do {
    case "MOVE": {
        if (count _payload < 1) exitWith {};
        private _pos = _payload select 0;
        if (count _pos < 2) exitWith {};
        _leader commandMove _pos;
    };

    case "ATTACK": {
        if (count _payload < 1) exitWith {};
        private _target = _payload select 0;
        if (isNull _target) exitWith {};
        _leader commandTarget _target;
        _leader commandAttack _target;
    };

    case "HOLD": {
        commandStop (units _group);
    };

    case "FORMATION": {
        if (count _payload < 1) exitWith {};
        private _formation = toUpper (_payload select 0);
        if (_formation in ["COLUMN", "WEDGE", "LINE", "FILE", "DIAMOND", "VEE"]) then {
            _group setFormation _formation;
        };
    };

    case "REGROUP": {
        private _members = units _group - [_leader];
        if (_members isNotEqualTo []) then {
            _members commandFollow _leader;
        };
    };
};
