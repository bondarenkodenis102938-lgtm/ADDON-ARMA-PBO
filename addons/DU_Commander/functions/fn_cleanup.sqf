private _active = missionNamespace getVariable ["DU_Commander_Active", false];

if (_active) then
{
    ["Terminate"] call BIS_fnc_EGSpectator;
};

private _old = missionNamespace getVariable ["DU_Commander_Original", objNull];
private _proxy = missionNamespace getVariable ["DU_Commander_Proxy", objNull];
private _proxyGroup = missionNamespace getVariable ["DU_Commander_ProxyGroup", grpNull];

missionNamespace setVariable ["DU_Commander_Active", false];

if (!isNull _old && {alive _old}) then
{
    _old setVariable ["DU_Commander_AI", false, true];
    _old enableAI "ALL";
};

if (!isNull _proxy) then
{
    hideObjectGlobal _proxy;
    deleteVehicle _proxy;
};

if (!isNull _proxyGroup) then
{
    deleteGroup _proxyGroup;
};

missionNamespace setVariable ["DU_Commander_Proxy", objNull];
missionNamespace setVariable ["DU_Commander_ProxyGroup", grpNull];
missionNamespace setVariable ["DU_Commander_Original", objNull];
missionNamespace setVariable ["DU_Commander_Group", grpNull];
