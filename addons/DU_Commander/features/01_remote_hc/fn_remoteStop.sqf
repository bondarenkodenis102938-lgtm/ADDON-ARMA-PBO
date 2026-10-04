/*
    IDEA 01 — END REMOTE HIGH COMMAND

    Only DU presentation state is cleaned up.

    The Antistasi HC group remains where Antistasi put it.
    Its leader, waypoints, ownership and AI state are not changed.
*/

if (!hasInterface) exitWith {};

[] call DU_fnc_guardian;

DU_Active = false;
DU_Commander_Group = grpNull;
DU_Commander_Leader = objNull;
DU_HC_GROUPS = [];

if (DU_PreviousHCBar) then {
    hcShowBar true;
} else {
    hcShowBar false;
};

DU_PreviousHCBar = false;
DU_PreviousHCSelection = [];

hintSilent "DU Commander: Remote HC Control ended.";
