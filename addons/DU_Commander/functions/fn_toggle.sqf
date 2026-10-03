if (!hasInterface) exitWith {};

if (missionNamespace getVariable ["DU_Commander_Active", false]) then
{
    [] call DU_fnc_takeControl;
}
else
{
    [] call DU_fnc_aiMode;
};
