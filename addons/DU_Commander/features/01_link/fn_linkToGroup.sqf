params [["_group", grpNull]];

if !([_group] call DU_fnc_validateLink) exitWith {false};

private _uid = getPlayerUID player;
private _existingUID = _group getVariable ["DU_LinkOwnerUID", ""];

if (_existingUID != "" && {!(_existingUID isEqualTo _uid)}) exitWith {
    hintSilent "DU Commander: this HC group is already linked by another player.";
    false
};

DU_Commander_Group = _group;
DU_Commander_Leader = leader _group;
DU_Link_UID = _uid;
DU_Active = true;

_group setVariable ["DU_LinkOwnerUID", _uid, true];

true
