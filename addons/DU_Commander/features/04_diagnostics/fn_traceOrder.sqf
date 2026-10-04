/*
    IDEA 04 — read-only order trace.

    Purpose:
      Discover what happens to a native DU order after it is issued.

    This function DOES NOT:
      - add/delete waypoints;
      - change PATCOM variables;
      - change behaviour/combat mode;
      - call doMove/move/stop to "correct" the AI;
      - interfere with Antistasi.

    It only records state to the local RPT for a short window.

    Why run here?
      applyOrder is executed on the AI leader's locality, so PATCOM/local AI
      variables visible here are the useful ones for the experiment.
*/

params [
    ["_group", grpNull],
    ["_order", ""],
    ["_seq", 0]
];

if (isNull _group) exitWith {};

private _leader = leader _group;
if (isNull _leader) exitWith {};

private _started = serverTime;
private _until = _started + 20;
private _lastSignature = "";

while {
    serverTime < _until
    && {!isNull _group}
    && {!isNull _leader}
} do {
    private _wpIndex = currentWaypoint _group;
    private _wpCount = count waypoints _group;

    private _wpType = if (_wpCount > _wpIndex) then {
        waypointType [_group, _wpIndex]
    } else {
        ""
    };

    private _wpName = if (_wpCount > _wpIndex) then {
        waypointName [_group, _wpIndex]
    } else {
        ""
    };

    private _patrolParams = _group getVariable ["PATCOM_Patrol_Params", []];
    private _patrolOrder = if (_patrolParams isNotEqualTo []) then {
        _patrolParams # 0
    } else {
        ""
    };

    private _taskX = _group getVariable ["taskX", ""];
    private _groupState = _group getVariable ["PATCOM_Group_State", ""];
    private _patrolControlled = _group getVariable ["PATCOM_Controlled", false];

    private _signature = str [
        currentCommand _leader,
        _wpIndex,
        _wpType,
        _wpName,
        _patrolOrder,
        _taskX,
        _groupState,
        _patrolControlled,
        formation _group,
        behaviour _leader,
        speedMode _group
    ];

    if !(_signature isEqualTo _lastSignature) then {
        diag_log format [
            "[DU][TRACE] seq=%1 order=%2 t=%3 leader=%4 local=%5 cmd=%6 wp=%7/%8 type=%9 name=%10 PATCOM=%11 task=%12 state=%13 controlled=%14 form=%15 behaviour=%16 speed=%17",
            _seq,
            _order,
            round (serverTime - _started),
            _leader,
            local _leader,
            currentCommand _leader,
            _wpIndex,
            _wpCount,
            _wpType,
            _wpName,
            _patrolOrder,
            _taskX,
            _groupState,
            _patrolControlled,
            formation _group,
            behaviour _leader,
            speedMode _group
        ];

        _lastSignature = _signature;
    };

    uiSleep 0.5;
};
