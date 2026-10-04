if (!hasInterface) exitWith {};

if (DU_Active) exitWith {
    [] call DU_fnc_close;
};

private _groups = [] call DU_fnc_refresh;

if (_groups isEqualTo []) exitWith {
    hintSilent "DU Commander: no usable High Command groups are exposed to this player.";
};

private _group = _groups select 0;

if !([_group] call DU_fnc_linkToGroup) exitWith {
    hintSilent "DU Commander: unable to link the selected HC group.";
};

[DU_Commander_Leader] call DU_fnc_guardianStart;

hintSilent format [
    "DU linked: %1 | Leader: %2",
    groupId _group,
    name DU_Commander_Leader
];
