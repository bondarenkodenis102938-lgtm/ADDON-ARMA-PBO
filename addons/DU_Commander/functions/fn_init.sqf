if (!hasInterface) exitWith {};

waitUntil {!isNull player};

if (missionNamespace getVariable ["DU_Commander_Initialized", false]) exitWith {};
missionNamespace setVariable ["DU_Commander_Initialized", true];

missionNamespace setVariable ["DU_Commander_Active", false];
missionNamespace setVariable ["DU_Commander_Original", objNull];
missionNamespace setVariable ["DU_Commander_Proxy", objNull];
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
            false
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
                [] call DU_fnc_cleanup;
                hint "DU Commander: AI-командир погиб.";
            };
        };
    };
};

hint "DU Commander загружен.\n\nCtrl+F10 — AI-командир ON/OFF";
