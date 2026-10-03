missionNamespace setVariable ["DU_Commander_Active", false];

private _proxy = missionNamespace getVariable ["DU_Commander_Proxy", objNull];

if (!isNull _proxy) then
{
    deleteVehicle _proxy;
};

missionNamespace setVariable ["DU_Commander_Proxy", objNull];
missionNamespace setVariable ["DU_Commander_Original", objNull];
missionNamespace setVariable ["DU_Commander_Group", grpNull];
