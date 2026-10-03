if (!hasInterface) exitWith {};

missionNamespace setVariable ["DU_Commander_Active", false];
missionNamespace setVariable ["DU_Commander_Group", grpNull];

showCommandingMenu "";
hcShowBar false;

hint "DU Commander: режим командования закрыт.\nГруппы Antistasi не изменены.";
