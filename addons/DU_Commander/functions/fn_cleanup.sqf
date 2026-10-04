if (!hasInterface) exitWith {};

missionNamespace setVariable ["DU_Commander_Active", false];
missionNamespace setVariable ["DU_Commander_Group", grpNull];
missionNamespace setVariable ["DU_HC_GROUPS", []];

showCommandingMenu "";