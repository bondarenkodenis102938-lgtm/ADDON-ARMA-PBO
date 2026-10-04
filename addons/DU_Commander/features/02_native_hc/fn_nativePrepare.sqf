/*
    IDEA 02 — NATIVE HIGH COMMAND

    IMPORTANT:
    Antistasi already registers its real AI groups with theBoss using hcSetGroup.
    That gives us the roster, but Antistasi does not guarantee that the vanilla
    High Command UI/scope is initialized for the player.

    DU therefore bootstraps ONLY the vanilla Arma High Command infrastructure
    for the existing player. This creates a HighCommand logic object, not an
    AI commander, proxy soldier, or replacement command brain.

    After that, all commands remain native Arma High Command.
*/

if (!hasInterface) exitWith {false};

private _scope = missionNamespace getVariable ["BIS_HC_mainscope", objNull];

if (isNull _scope) then {
    /*
        Proven Arma pattern: create the vanilla HighCommand logic locally and
        execute BIS's own HC init script.

        DO NOT replace this with custom MOVE/ATTACK/etc. code. The purpose of
        this function is only to make the native HC UI/command mode exist.
    */
    createCenter sideLogic;

    private _logicGroup = createGroup sideLogic;
    _scope = _logicGroup createUnit ["HighCommand", [0, 0, 0], [], 0, "NONE"];

    /*
        BIS HC uses this variable as its main scope marker. Keep it as an
        engine-compatible mission variable because it is a Logic object.
    */
    missionNamespace setVariable ["BIS_HC_mainscope", _scope];

    /*
        The player becomes the vanilla HC commander by synchronization.
        This does NOT change player identity or control another unit.
    */
    player synchronizeObjectsAdd [_scope];

    /*
        Run Bohemia's own High Command bootstrap. We do not copy or replace
        the engine script in DU.
    */
    [_scope] execVM "\A3\modules_f\HC\data\scripts\hc.sqf";

    /*
        hc.sqf initializes asynchronously. Give the native UI a moment to
        install its local state before selecting/showing the group.
    */
    private _deadline = diag_tickTime + 5;
    waitUntil {
        (!isNull _scope && {!isNil "HC_lastUnitReporting"})
        || {diag_tickTime > _deadline}
    };
};

/*
    Antistasi owns this real group. Re-registering it is harmless and ensures
    the vanilla HC scope sees it after initialization.
*/
if !(_group in (hcAllGroups player)) then {
    player hcSetGroup [_group];
};

hcSelectGroup [player, _group];
hcShowBar true;

true
