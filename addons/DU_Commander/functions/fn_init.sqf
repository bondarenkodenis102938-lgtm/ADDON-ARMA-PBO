/*
    DU COMMANDER — FINAL ARCHITECTURE

    Player body + Native High Command + detached Guardian camera.

    The player never becomes the AI leader.
    DU does not create a second command system.
*/

if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["DU_Initialized", false]) exitWith {};

DU_Initialized = true;
DU_Active = false;

DU_Commander_Group = grpNull;
DU_Commander_Leader = objNull;
DU_HC_GROUPS = [];

DU_PreviousHCBar = false;
DU_PreviousHCSelection = [];

DU_Guardian_Camera = objNull;
DU_Guardian_Display = displayNull;
DU_Guardian_KeyDownEH = -1;
DU_Guardian_KeyUpEH = -1;
DU_Guardian_MouseEH = -1;
DU_Guardian_MouseButtonEH = -1;

DU_Camera_Keys = createHashMap;
DU_Camera_Yaw = 0;
DU_Camera_Pitch = -25;
DU_Camera_Position = [0, 0, 50];

waitUntil {!isNull player && {!isNull (findDisplay 46)}};

private _display = findDisplay 46;

_display displayAddEventHandler ["KeyDown", {
    params ["_display", "_key", "_shift", "_ctrl", "_alt"];

    /*
        Ctrl + F10 opens/closes Remote HC.

        Ctrl + Space is intentionally left untouched because it belongs to
        native Arma High Command.
    */
    if (_ctrl && {_key isEqualTo 0x44}) then {
        [] call DU_fnc_toggle;
        true
    } else {
        false
    };
}];

addMissionEventHandler ["HCGroupSelectionChanged", {
    _this call DU_fnc_onSelectionChanged;
}];

hint "DU Commander ready. Ctrl+F10 = Remote HC Commander.";
