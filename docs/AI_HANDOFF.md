# DU Commander — AI handoff

## Intent

Build a thin command and Guardian layer for existing Antistasi Ultimate HC groups. The player remains the player.

## Never do

Do not add:
- selectPlayer in DU;
- proxy units;
- replacement AI;
- a second AI brain;
- wholesale copying of Arma command menus;
- generic deletion of Antistasi waypoints;
- rewriting PATCOM.

## Current ideas

01 link:
features/01_link

02 native command gateway:
features/02_command

03 Guardian camera:
features/03_guardian

04 order coexistence trace:
features/04_diagnostics

## Verified Antistasi source

Repository: Antistasi-Ultimate-Community/A3-Antistasi-Ultimate
Branch inspected: unstable

Exact paths:
- A3A/addons/core/functions/REINF/fn_controlHCsquad.sqf
- A3A/addons/core/functions/REINF/fn_spawnHCGroup.sqf
- A3A/addons/scrt/Common/fn_common_hcTransfer.sqf
- A3A/addons/gui/functions/GUI/fn_commanderTab.sqf
- A3A/addons/gui/functions/GUI/fn_getGroupInfo.sqf
- A3A/addons/patcom/functions/Patcom/fn_patrolCommander.sqf
- A3A/addons/patcom/functions/Patcom/fn_patrolLoop.sqf
- A3A/addons/patcom/functions/Patcom/fn_patrolGroupVariables.sqf
- A3A/addons/patcom/functions/Patcom/fn_patrolCreateWaypoint.sqf
- A3A/addons/patcom/functions/Patcom/fn_patrolSetCombatModes.sqf
- A3A/addons/core/functions/AI/fn_attackDrillAI.sqf
- A3A/addons/scrt/Misc/fn_misc_orbitingCamera.sqf
- A3A/addons/scrt/Misc/fn_misc_followCamera.sqf
- A3A/addons/scrt/UI/fn_ui_toggleCommanderMenu.sqf

Confirmed:
1. HC squads are normal Arma groups.
2. Ultimate registers HC groups with theBoss hcSetGroup.
3. Existing Ultimate HC possession uses selectPlayer.
4. Existing camera helpers target player.
5. PATCOM can create/update waypoints and combat modes.
6. Some HC groups can also start A3A_fnc_attackDrillAI.
7. Native command functions are locality-sensitive, so DU sends execution to the real AI leader's locality.
8. The first useful coexistence strategy is observation, not fighting the Antistasi AI.

## Current code change

Idea 02 now sends MOVE/ATTACK/TARGET commands to all units in the linked group instead of only the leader.

Idea 04 adds a 20-second read-only diag_log trace after every accepted DU order.

## Next experiment

Do not build the full UI yet.

Use the mission debug console against one real HC group:

    [] call DU_fnc_refresh;
    private _g = (DU_HC_GROUPS select 0);
    [_g] call DU_fnc_linkToGroup;
    ["MOVE", [getPosASL player vectorAdd [100, 0, 0]]] call DU_fnc_issueOrder;

Then inspect RPT.

Repeat:

    ["HOLD", []] call DU_fnc_issueOrder;
    ["REGROUP", []] call DU_fnc_issueOrder;
    ["FORMATION", ["WEDGE"]] call DU_fnc_issueOrder;

Important: the exact test position format may need adjustment to the mission context. Do not assume the result; inspect the RPT.

## What to learn from the trace

We need to determine:

A. Does the native command survive for seconds or is it immediately replaced?

B. Does PATCOM create a new/current waypoint after the command?

C. Does PATCOM_Form_Set or patrolHandleFormation overwrite DU formation changes?

D. Does attackDrillAI fight the order through taskX, assault, hide, or flank logic?

E. Does AI locality remain stable or move after leader changes?

Only after these are answered should Idea 05 define a real DU order ownership/translation policy.

## Documentation rule

Every new idea gets:
- its own features/NN_name directory;
- its own docs/ideas/NN_name.md;
- an update to this handoff file with facts, failures, and next experiment.

Do not turn assumptions into facts. Use exact Antistasi source paths for source-derived statements.
