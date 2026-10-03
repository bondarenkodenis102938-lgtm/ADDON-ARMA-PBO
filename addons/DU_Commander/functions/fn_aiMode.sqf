if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["DU_Commander_Active", false]) exitWith {};

private _old = player;

if (isNull _old || {!alive _old}) exitWith
{
    hint "DU Commander: текущий персонаж недоступен.";
};

private _grp = group _old;
private _pos = getPosATL _old;
private _dir = getDir _old;
private _loadout = getUnitLoadout _old;
private _type = typeOf _old;

missionNamespace setVariable ["DU_Commander_Original", _old];
missionNamespace setVariable ["DU_Commander_Group", _grp];

private _proxy = _grp createUnit [_type, _pos, [], 0, "NONE"];

_proxy setDir _dir;
_proxy setUnitLoadout _loadout;
_proxy allowDamage false;
_proxy hideObjectGlobal true;
_proxy enableSimulationGlobal false;

_grp selectLeader _old;

_old enableAI "ALL";
_old setBehaviour "AWARE";
_old setCombatMode "YELLOW";
_old setSpeedMode "NORMAL";
_old setFormation "WEDGE";
_old setVariable ["DU_Commander_AI", true, true];
_proxy setVariable ["DU_Commander_Proxy", true, true];

missionNamespace setVariable ["DU_Commander_Proxy", _proxy];
missionNamespace setVariable ["DU_Commander_Active", true];

selectPlayer _proxy;

_grp selectLeader _old;
_old switchCamera "INTERNAL";

hint "DU COMMANDER: AI ON\n\nТвой оригинальный персонаж теперь управляется AI.\n\nF10 — перехватить управление обратно.";
