if (!hasInterface) exitWith {};

waitUntil {!isNull player};
waitUntil {!isNull findDisplay 46};

if (missionNamespace getVariable ["DU_Commander_Initialized", false]) exitWith {};
missionNamespace setVariable ["DU_Commander_Initialized", true];
missionNamespace setVariable ["DU_Commander_Active", false];
missionNamespace setVariable ["DU_Commander_Group", grpNull];
missionNamespace setVariable ["DU_Commander_KeyLock", false];

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

[] spawn
{
    while {true} do
    {
        sleep 3;

        if (missionNamespace getVariable ["DU_Commander_Active", false]) then
        {
            private _group = missionNamespace getVariable ["DU_Commander_Group", grpNull];

            if (isNull _group || {isNull leader _group} || {!alive leader _group}) then
            {
                missionNamespace setVariable ["DU_Commander_Group", grpNull];
            };
        };
    };
};

hint "DU Commander загружен.\n\nCtrl+F10 — открыть командование существующими Antistasi HC-отрядами.";