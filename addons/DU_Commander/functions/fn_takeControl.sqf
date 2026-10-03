if (!hasInterface) exitWith {};

missionNamespace setVariable ["DU_Commander_Active", false];
missionNamespace setVariable ["DU_Commander_Group", grpNull];

showCommandingMenu "";

hint "DU Commander: интерфейс командования закрыт.\nAI и High Command Antistasi не изменены.";
