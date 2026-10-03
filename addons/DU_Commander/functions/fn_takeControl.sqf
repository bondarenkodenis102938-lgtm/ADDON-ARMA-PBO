if (!hasInterface) exitWith {};
if !(missionNamespace getVariable ["DU_Commander_Active", false]) exitWith {};

private _old = missionNamespace getVariable ["DU_Commander_Original", objNull];
private _proxy = missionNamespace getVariable ["DU_Commander_Proxy", objNull];
private _proxyGroup = missionNamespace getVariable ["DU_Commander_ProxyGroup", grpNull];

if (isNull _old || {!alive _old}) exitWith
{
    ["Terminate"] call BIS_fnc_EGSpectator;
    [] call DU_fnc_cleanup;
    hint "DU Commander: тело командира погибло. Вернуться уже нельзя.";
};

missionNamespace setVariable ["DU_Commander_Active", false];

["Terminate"] call BIS_fnc_EGSpectator;

if (!isNull _proxy) then
{
    hideObjectGlobal _proxy;
};

selectPlayer _old;

waitUntil {sleep 0.1; player isEqualTo _old};

_old setVariable ["DU_Commander_AI", false, true];
_old enableAI "ALL";

if (!isNull _proxy) then
{
    deleteVehicle _proxy;
};

if (!isNull _proxyGroup) then
{
    deleteGroup _proxyGroup;
};

missionNamespace setVariable ["DU_Commander_Proxy", objNull];
missionNamespace setVariable ["DU_Commander_ProxyGroup", grpNull];
missionNamespace setVariable ["DU_Commander_Original", _old];
missionNamespace setVariable ["DU_Commander_Group", group _old];

hint "DU COMMANDER: УПРАВЛЕНИЕ ВОЗВРАЩЕНО

Ты снова управляешь своим настоящим телом.";
