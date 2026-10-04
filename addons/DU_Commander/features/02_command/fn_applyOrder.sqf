/*
    IDEA 02 — execution side.

    Important Arma fact:
    commandMove/commandTarget/commandAttack take the unit(s) that receive
    the command. The old prototype targeted only the leader, which meant
    we were testing leader movement rather than commanding the whole HC group.

    Therefore:
      units _group commandMove _pos;
      units _group commandTarget _target;
      units _group commandAttack _target;

    No waypoint is created, deleted, or rewritten by DU.

    IDEA 04 starts a diagnostic trace after the command. The trace is read-only
    and exists specifically to discover whether PATCOM/another AI loop later
    replaces our transient native command.
*/

params [
    ["_group", grpNull],
    ["_order", ""],
    ["_payload", []],
    ["_requesterUID", ""]
];

if (isNull _group) exitWith {};

private _leader = leader _group;
if (isNull _leader) exitWith {};
if (!alive _leader) exitWith {};
if (!local _leader) exitWith {};

private _linkedUID = _group getVariable ["DU_LinkOwnerUID", ""];
if (_linkedUID != "" && {!(_requesterUID isEqualTo _linkedUID)}) exitWith {};

private _normalizedOrder = toUpper _order;
private _accepted = false;

switch (_normalizedOrder) do {
    case "MOVE": {
        if (count _payload < 1) exitWith {};
        private _pos = _payload select 0;

        if (count _pos < 2) exitWith {};

        units _group commandMove _pos;
        _accepted = true;
    };

    case "ATTACK": {
        if (count _payload < 1) exitWith {};
        private _target = _payload select 0;

        if (isNull _target) exitWith {};

        units _group commandTarget _target;
        units _group commandAttack _target;
        _accepted = true;
    };

    case "HOLD": {
        commandStop (units _group);
        _accepted = true;
    };

    case "FORMATION": {
        if (count _payload < 1) exitWith {};
        private _formation = toUpper (_payload select 0);

        /*
            Keep this whitelist small during the prototype.
            PATCOM itself may temporarily change formation later; that is exactly
            one of the behaviors Idea 04 is meant to expose.
        */
        if (_formation in ["COLUMN", "WEDGE", "LINE", "FILE", "DIAMOND", "VEE"]) then {
            _group setFormation _formation;
            _accepted = true;
        };
    };

    case "REGROUP": {
        private _members = units _group - [_leader];

        if (_members isNotEqualTo []) then {
            _members commandFollow _leader;
        };

        _accepted = true;
    };
};

if (_accepted) then {
    private _seq = (_group getVariable ["DU_OrderSeq", 0]) + 1;

    _group setVariable ["DU_OrderSeq", _seq, true];
    _group setVariable ["DU_LastOrder", _normalizedOrder, true];
    _group setVariable ["DU_LastOrderTime", serverTime, true];

    /*
        Development phase:
        observe instead of fighting PATCOM. The monitor is intentionally
        separate from the command executor so it can be removed later without
        changing the order semantics.
    */
    [_group, _normalizedOrder, _seq] spawn DU_fnc_traceOrder;
};
