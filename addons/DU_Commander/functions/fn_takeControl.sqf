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

missionNamespace setVariable ["DU_Commander_Active", false];

_old setVariable ["DU_Commander_AI", false, true];
_old enableAI "ALL";
_old setBehaviour "AWARE";
_old setCombatMode "YELLOW";
_old setSpeedMode "NORMAL";

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

hint "DU COMMANDER: УПРАВЛЕНИЕ ВОЗВРАЩЕНО\n\nТы снова управляешь своим командиром.";
