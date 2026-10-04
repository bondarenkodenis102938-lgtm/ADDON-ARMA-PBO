/*
    IDEA 01 — REMOTE HIGH COMMAND

    The user's requested behavior is the Antistasi Control HC Squad experience,
    except the player's body is never replaced by the AI leader.

    Antistasi's built-in Control HC Squad function uses selectPlayer.
    DU deliberately does not call that function.

    Preconditions match the Antistasi commander path:
      player must be theBoss.

    The existing HC roster is reused exactly as-is.
*/

if (!hasInterface) exitWith {false};

if (isNil "theBoss") exitWith {
    hint "DU Commander: Antistasi commander object is unavailable.";
    false
};

if (player != theBoss) exitWith {
    hint "DU Commander: only the Antistasi commander can use Remote HC Control.";
    false
};

private _groups = [] call DU_fnc_refresh;

if (_groups isEqualTo []) exitWith {
    hint "DU Commander: no live AI High Command groups are available.";
    false
};

DU_PreviousHCBar = hcShownBar player;
DU_PreviousHCSelection = +hcSelected player;

private _group = grpNull;

private _selectedGroups = hcSelected player;
{
    if (_x in _groups) exitWith {
        _group = _x;
    };
} forEach _selectedGroups;

if (isNull _group) then {
    _group = _groups # 0;
};

DU_Commander_Group = _group;
DU_Commander_Leader = leader _group;
DU_Active = true;

[_group] call DU_fnc_nativePrepare;
[] call DU_fnc_guardian;

hintSilent format [
    "REMOTE HC: %1 | LEADER: %2",
    groupId _group,
    name (leader _group)
];

true
