# DU Commander — AI handoff

## READ FIRST

Read docs/DU_MASTER_PROMPT.md.

The final goal is Remote High Command Observer, not a custom AI commander.

## Current code

Core:
- functions/fn_init.sqf
- functions/fn_toggle.sqf
- functions/fn_refresh.sqf

Remote HC:
- features/01_remote_hc/fn_remoteStart.sqf
- features/01_remote_hc/fn_remoteStop.sqf

Native HC:
- features/02_native_hc/fn_nativePrepare.sqf

Guardian:
- features/03_guardian/fn_guardian.sqf

Selection:
- features/04_selection/fn_onSelectionChanged.sqf

## Verified Antistasi source

Reference repository:
Antistasi-Ultimate-Community/A3-Antistasi-Ultimate

Branch:
unstable

Relevant paths:
- A3A/addons/core/functions/REINF/fn_controlHCsquad.sqf
- A3A/addons/core/functions/REINF/fn_spawnHCGroup.sqf
- A3A/addons/scrt/Common/fn_common_hcTransfer.sqf
- A3A/addons/gui/functions/GUI/fn_commanderTab.sqf
- A3A/addons/gui/functions/GUI/fn_getGroupInfo.sqf
- A3A/addons/patcom/functions/Patcom/fn_patrolCommander.sqf
- A3A/addons/patcom/functions/Patcom/fn_patrolLoop.sqf
- A3A/addons/patcom/functions/Patcom/fn_patrolCreateWaypoint.sqf
- A3A/addons/patcom/functions/Patcom/fn_patrolSetCombatModes.sqf
- A3A/addons/core/functions/AI/fn_attackDrillAI.sqf
- A3A/addons/scrt/Misc/fn_misc_orbitingCamera.sqf
- A3A/addons/scrt/Misc/fn_misc_followCamera.sqf
- A3A/addons/scrt/UI/fn_ui_toggleCommanderMenu.sqf

## Confirmed facts

1. Antistasi HC squads are normal Arma groups.
2. Ultimate registers HC groups with theBoss using hcSetGroup.
3. Built-in Control HC Squad uses selectPlayer.
4. Native Arma High Command is designed to command subordinate groups and supports native group selection and map orders.
5. PATCOM can independently update waypoint and combat behavior.
6. Some groups also use attackDrillAI.

## Final architecture

DU must:
- leave the player body alone;
- leave the AI group alone;
- leave Antistasi AI alone;
- enable/select native HC;
- provide a detached observer camera.

DU must not:
- create a command replacement;
- remote-execute its own movement/attack orders;
- become a second AI brain.

## What remains to test in-game

1. Confirm hcShowBar true gives the desired native HC command state inside Ultimate.
2. Confirm native HC F-key selection updates the Guardian target.
3. Confirm the free camera input does not interfere with native HC map commands.
4. Confirm Remote HC works cleanly on dedicated server.
5. Confirm player weapon/body input is adequately isolated while the camera is active.

## Next AI rule

Do not redesign the command layer unless in-game evidence proves native HC cannot provide the requested behavior.

If native HC works, only improve:
- camera UX;
- group selection/focus;
- exit/restore behavior;
- optional non-invasive HUD.

Do not reintroduce the discarded command gateway.
