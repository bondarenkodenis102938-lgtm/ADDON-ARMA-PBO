if (!hasInterface) exitWith {};

[] spawn
{
    waitUntil {!isNull player && {!isNull findDisplay 46}};

    if (missionNamespace getVariable ["DU_Commander_Initialized", false]) exitWith {};

    missionNamespace setVariable ["DU_Commander_Initialized", true];
    missionNamespace setVariable ["DU_Commander_Active", false];
    missionNamespace setVariable ["DU_Commander_Group", grpNull];
    missionNamespace setVariable ["DU_Commander_KeyLock", false];
    missionNamespace setVariable ["DU_HC_GROUPS", []];

    private _display = findDisplay 46;

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

    hint "DU Commander загружен.\n\nCtrl+F10 — командование существующими Antistasi HC-отрядами.";
};