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

## Verified Antistasi source

Repository: Antistasi-Ultimate-Community/A3-Antistasi-Ultimate
Branch inspected: unstable

Exact paths:
- A3A/addons/core/functions/REINF/fn_controlHCsquad.sqf
- A3A/addons/core/functions/REINF/fn_spawnHCGroup.sqf
- A3A/addons/scrt/Common/fn_common_hcTransfer.sqf
- A3A/addons/gui/functions/GUI/fn_commanderTab.sqf
- A3A/addons/patcom/functions/Patcom/fn_patrolCommander.sqf
- A3A/addons/scrt/Misc/fn_misc_orbitingCamera.sqf
- A3A/addons/scrt/Misc/fn_misc_followCamera.sqf
- A3A/addons/scrt/UI/fn_ui_toggleCommanderMenu.sqf

Confirmed:
1. HC squads are normal Arma groups.
2. Ultimate registers HC groups with theBoss hcSetGroup.
3. Existing Ultimate HC possession uses selectPlayer.
4. Existing camera helpers target player.
5. PATCOM owns/updates its own order/state variables, so DU must not claim permanent control.
6. The first command layer should therefore be a locality-safe native-command relay.

## Next AI experiment

Do not start the UI yet.

First test:
1. link one real HC group;
2. issue MOVE to a known position;
3. issue HOLD;
4. issue REGROUP;
5. issue FORMATION;
6. run the same test on dedicated server with HC AI local to server and with headless client;
7. observe whether PATCOM immediately overrides the order.

After this experiment, update this file with confirmed behavior and the next smallest idea.

## Documentation rule

Every new idea gets:
- its own features/NN_name directory;
- its own docs/ideas/NN_name.md;
- an update to this handoff file with facts, failures, and next experiment.

Do not turn assumptions into facts. Use exact Antistasi source paths for source-derived statements.
