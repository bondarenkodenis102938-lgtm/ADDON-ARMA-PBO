if (!hasInterface) exitWith {};
if !(missionNamespace getVariable ["DU_Commander_Active", false]) exitWith {};

private _old = missionNamespace getVariable ["DU_Commander_Original", objNull];
private _proxy = missionNamespace getVariable ["DU_Commander_Proxy", objNull];
private _grp = missionNamespace getVariable ["DU_Commander_Group", grpNull];

if (isNull _old || {!alive _old}) exitWith
{
    [] call DU_fnc_cleanup;
    hint "DU Commander: AI-командир погиб, управление вернуть нельзя.";
};

_old setVariable ["DU_Commander_AI", false, true];
_old enableAI "ALL";

selectPlayer _old;
_old switchCamera "INTERNAL";

if (!isNull _grp) then
{
    _grp selectLeader _old;
};

if (!isNull _proxy) then
{
    deleteVehicle _proxy;
};

missionNamespace setVariable ["DU_Commander_Proxy", objNull];
missionNamespace setVariable ["DU_Commander_Original", _old];
missionNamespace setVariable ["DU_Commander_Group", _grp];
missionNamespace setVariable ["DU_Commander_Active", false];

hint "DU COMMANDER: УПРАВЛЕНИЕ ВОЗВРАЩЕНО\n\nТы снова управляешь своим командиром.";
