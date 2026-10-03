if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["DU_Commander_Active", false]) exitWith {};

private _old = player;

if (isNull _old || {!alive _old}) exitWith
{
    hint "DU Commander: текущий персонаж недоступен.";
};

private _grp = group _old;
private _type = typeOf _old;
private _uid = getPlayerUID _old;

missionNamespace setVariable ["DU_Commander_Original", _old];
missionNamespace setVariable ["DU_Commander_Group", _grp];
missionNamespace setVariable ["DU_Commander_UID", _uid];

private _proxyGroup = createGroup [side _old, true];
private _proxy = _proxyGroup createUnit [_type, getPosATL _old, [], 0, "NONE"];

_proxy setDir getDir _old;
_proxy setUnitLoadout getUnitLoadout _old;
_proxy setVariable ["DU_Commander_Proxy", true, true];
_proxy setVariable ["DU_Commander_Original", _old, true];
_proxy setVariable ["A3A_playerUID", _uid, true];
_proxy setVariable ["owner", _old, true];
_proxy allowDamage false;
_proxy hideObjectGlobal true;
_proxy enableSimulationGlobal true;

missionNamespace setVariable ["DU_Commander_Proxy", _proxy];
missionNamespace setVariable ["DU_Commander_ProxyGroup", _proxyGroup];
missionNamespace setVariable ["DU_Commander_Active", true];

_old setVariable ["DU_Commander_AI", true, true];
_old enableAI "ALL";

selectPlayer _proxy;

waitUntil {sleep 0.1; player isEqualTo _proxy};

[
    "Initialize",
    [
        player,
        [side _old],
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true
    ]
] call BIS_fnc_EGSpectator;

hint "DU COMMANDER: TACTICAL GHOST ON

Твоё настоящее тело осталось под обычным AI.
Ты сейчас призрак-наблюдатель.

WASD / мышь — свободная камера.
Ctrl+1 AUTO
Ctrl+2 ЛЕЧЬ
Ctrl+3 ВСТАТЬ
Ctrl+4 WEDGE
Ctrl+5 LINE
Ctrl+6 COLUMN
Ctrl+7 HOLD FIRE
Ctrl+8 FIRE AT WILL
Ctrl+9 ENGAGE AT WILL
Ctrl+0 HOLD + ENGAGE

Ctrl+F10 — вернуться в тело.";
