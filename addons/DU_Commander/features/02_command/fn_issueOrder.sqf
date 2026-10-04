/*
    IDEA 02 — request side.

    Process:
    1. Validate the still-linked real HC group.
    2. Resolve the current real leader.
    3. Send the order packet to the machine where that leader is local.

    The packet contains the requester's UID, not a player object reference.
    This keeps the authorization check independent of player-object locality.
*/

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

private _requesterUID = getPlayerUID player;
private _packet = [_group, _order, _payload, _requesterUID];

if (local _leader) then {
    _packet call DU_fnc_applyOrder;
} else {
    _packet remoteExecCall ["DU_fnc_applyOrder", _leader];
};

true
