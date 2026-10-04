/*
    FINAL USER ENTRY POINT.

    Ctrl+F10:
      enter Remote HC Observer
      or leave it.

    There is intentionally no custom MOVE/ATTACK menu here.
    Native High Command is the command system.
*/

if (!hasInterface) exitWith {};

if (DU_Active) exitWith {
    [] call DU_fnc_remoteStop;
};

[] call DU_fnc_remoteStart;
