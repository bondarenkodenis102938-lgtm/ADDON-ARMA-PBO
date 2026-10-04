/*
    IDEA 02 — NATIVE HIGH COMMAND

    DU intentionally contains no replacement command implementation.

    Native High Command already supports:
      - subordinate group selection;
      - command mode;
      - map-based movement orders;
      - native command menus;
      - group status/command bar.

    DU only forces the real Antistasi HC group into the native selection
    and makes sure the native HC bar is visible.

    No custom MOVE/ATTACK/HOLD/FORMATION relay exists in the final build.
*/

params [["_group", grpNull]];

if (!hasInterface) exitWith {false};
if (isNull _group) exitWith {false};

if !(_group in (hcAllGroups player)) exitWith {false};

hcSelectGroup [player, _group];
hcShowBar true;

true
