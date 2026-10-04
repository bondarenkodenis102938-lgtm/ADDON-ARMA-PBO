# Idea 01 — real HC link

Code:
- addons/DU_Commander/functions/fn_refresh.sqf
- features/01_link/fn_validateLink.sqf
- features/01_link/fn_linkToGroup.sqf

The link is a reference only. It stores the group and current real leader.

It does not use selectPlayer, create a unit, change group leadership, change ownership, or remove waypoints.

Test:

    private _groups = [] call DU_fnc_refresh;
    [_groups select 0] call DU_fnc_linkToGroup;

Expected: player and group membership remain unchanged.
