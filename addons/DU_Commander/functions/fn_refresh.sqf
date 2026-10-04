/*
    Return the real HC groups already exposed to the Antistasi commander.

    DU does not add, remove, recreate or transfer these groups.
*/

if (!hasInterface) exitWith {[]};

private _groups = hcAllGroups player;

_groups = _groups select {
    !isNull _x
    && {count units _x > 0}
    && {!isNull (leader _x)}
    && {alive (leader _x)}
    && {!isPlayer (leader _x)}
    && {side (leader _x) isEqualTo side player}
};

DU_HC_GROUPS = _groups;
_groups
