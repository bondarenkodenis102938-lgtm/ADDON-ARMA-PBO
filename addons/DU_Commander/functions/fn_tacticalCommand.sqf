if (!hasInterface) exitWith {};
if !(missionNamespace getVariable ["DU_Commander_Active", false]) exitWith {};

params [["_command", "", [""]]];

private _old = missionNamespace getVariable ["DU_Commander_Original", objNull];
private _grp = missionNamespace getVariable ["DU_Commander_Group", grpNull];

if (isNull _old || {!alive _old} || {isNull _grp}) exitWith {};

switch (_command) do
{
    case "AUTO":
    {
        { _x setUnitPos "AUTO"; } forEach units _grp;
        hint "DU: весь сквад — AUTO.";
    };
    case "DOWN":
    {
        _grp setCombatMode "BLUE";
        { _x setUnitPos "DOWN"; } forEach units _grp;
        hint "DU: весь сквад — ЛЕЖАТЬ.";
    };
    case "UP":
    {
        { _x setUnitPos "UP"; } forEach units _grp;
        _grp setCombatMode "YELLOW";
        hint "DU: весь сквад — ВСТАТЬ / FIRE AT WILL.";
    };
    case "WEDGE":
    {
        _grp setFormation "WEDGE";
        hint "DU: строй — КЛИН.";
    };
    case "LINE":
    {
        _grp setFormation "LINE";
        hint "DU: строй — ЛИНИЯ.";
    };
    case "COLUMN":
    {
        _grp setFormation "COLUMN";
        hint "DU: строй — КОЛОННА.";
    };
    case "HOLD":
    {
        _grp setCombatMode "GREEN";
        hint "DU: HOLD FIRE.";
    };
    case "FIRE":
    {
        _grp setCombatMode "YELLOW";
        hint "DU: FIRE AT WILL.";
    };
    case "ENGAGE":
    {
        _grp setCombatMode "RED";
        hint "DU: ENGAGE AT WILL.";
    };
    case "HOLD_ENGAGE":
    {
        _grp setCombatMode "WHITE";
        hint "DU: HOLD FIRE / ENGAGE AT WILL.";
    };
};