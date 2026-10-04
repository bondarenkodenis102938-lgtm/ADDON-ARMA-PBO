/*
    IDEA 04 — NATIVE HC SELECTION BRIDGE

    The player selects groups using the native High Command bar/map.

    DU does not create a second group selector.

    When native HC selection changes, DU changes only the Guardian target.
*/

params ["_group", "_isSelected"];

if (!DU_Active) exitWith {};
if (!_isSelected) exitWith {};
if (isNull _group) exitWith {};

private _groups = [] call DU_fnc_refresh;

if !(_group in _groups) exitWith {};

DU_Commander_Group = _group;
DU_Commander_Leader = leader _group;

if (!isNull DU_Guardian_Camera && {!isNull DU_Commander_Leader}) then {
    private _pos = getPosASL DU_Commander_Leader;
    private _yaw = DU_Camera_Yaw;

    DU_Camera_Position = [
        (_pos # 0) - (sin _yaw) * 35,
        (_pos # 1) - (cos _yaw) * 35,
        (_pos # 2) + 25
    ];
};
