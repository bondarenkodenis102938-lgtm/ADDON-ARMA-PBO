if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["DU_Initialized", false]) exitWith {};

DU_Initialized = true;
DU_Active = false;
DU_HC_GROUPS = [];
DU_Commander_Group = grpNull;
DU_Commander_Leader = objNull;
DU_Link_UID = "";
DU_Guardian_Active = false;
DU_Guardian_Camera = objNull;
DU_Guardian_Token = 0;

waitUntil {!isNull player && {!isNull (findDisplay 46)}};

private _display = findDisplay 46;
_display displayAddEventHandler ["KeyDown", {
    params ["_display", "_key", "_shift", "_ctrl", "_alt"];

    if (_ctrl && {_key isEqualTo 0x44}) then {
        [] call DU_fnc_toggle;
        true
    } else {
        false
    };
}];

hint "DU Commander rewrite loaded. Ctrl+F10 toggles the first exposed HC group and Guardian test state.";
