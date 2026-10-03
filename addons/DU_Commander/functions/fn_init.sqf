if (!hasInterface) exitWith {};

waitUntil {!isNull player};

if (missionNamespace getVariable ["DU_Commander_Initialized", false]) exitWith {};
missionNamespace setVariable ["DU_Commander_Initialized", true];

missionNamespace setVariable ["DU_Commander_Active", false];
missionNamespace setVariable ["DU_Commander_Original", objNull];
missionNamespace setVariable ["DU_Commander_Proxy", objNull];
missionNamespace setVariable ["DU_Commander_ProxyGroup", grpNull];
missionNamespace setVariable ["DU_Commander_Group", grpNull];
missionNamespace setVariable ["DU_Commander_KeyLock", false];

private _display = findDisplay 46;

if (!isNull _display) then
{
    _display displayAddEventHandler ["KeyDown",
    {
        params ["_display", "_key", "_shift", "_ctrl", "_alt"];

        if (_key isEqualTo 0x44 && {_ctrl} && {!_shift} && {!_alt}) then
        {
            if !(missionNamespace getVariable ["DU_Commander_KeyLock", false]) then
            {
                missionNamespace setVariable ["DU_Commander_KeyLock", true];
                [] call DU_fnc_toggle;
            };
            true
        }
        else
        {
            if (missionNamespace getVariable ["DU_Commander_Active", false] && {_ctrl} && {!_shift} && {!_alt}) then
            {
                switch (_key) do
                {
                    case 0x02: { ["AUTO"] call DU_fnc_tacticalCommand; true };
                    case 0x03: { ["DOWN"] call DU_fnc_tacticalCommand; true };
                    case 0x04: { ["UP"] call DU_fnc_tacticalCommand; true };
                    case 0x05: { ["WEDGE"] call DU_fnc_tacticalCommand; true };
                    case 0x06: { ["LINE"] call DU_fnc_tacticalCommand; true };
                    case 0x07: { ["COLUMN"] call DU_fnc_tacticalCommand; true };
                    case 0x08: { ["HOLD"] call DU_fnc_tacticalCommand; true };
                    case 0x09: { ["FIRE"] call DU_fnc_tacticalCommand; true };
                    case 0x0A: { ["ENGAGE"] call DU_fnc_tacticalCommand; true };
                    case 0x0B: { ["HOLD_ENGAGE"] call DU_fnc_tacticalCommand; true };
                    default { false };
                };
            }
            else
            {
                false
            };
        };
    }];

    _display displayAddEventHandler ["KeyUp",
    {
        params ["_display", "_key"];

        if (_key isEqualTo 0x44) then
        {
            missionNamespace setVariable ["DU_Commander_KeyLock", false];
        };

        false
    }];
};

[] spawn
{
    while {true} do
    {
        sleep 2;

        if (missionNamespace getVariable ["DU_Commander_Active", false]) then
        {
            private _old = missionNamespace getVariable ["DU_Commander_Original", objNull];

            if (isNull _old || {!alive _old}) then
            {
                ["Terminate"] call BIS_fnc_EGSpectator;
                [] call DU_fnc_cleanup;
                hint "DU Commander: твоё тело погибло.";
            };
        };
    };
};

hint "DU Commander загружен.

Ctrl+F10 — Tactical Ghost ON/OFF";
