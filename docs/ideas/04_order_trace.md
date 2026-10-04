# Idea 04 — order coexistence trace

## Goal

Do not guess how DU and Antistasi AI coexist.

After a native DU command is accepted, observe the real AI leader's state for 20 seconds on the same machine where the leader is local.

## Why this exists

Antistasi Ultimate's PATCOM can:
- select patrol orders;
- create/update its own waypoints;
- set formation;
- set behaviour/speed/combat modes;
- react to known enemies.

Ultimate's attack drill can also run a separate AI loop for some HC groups.

The correct response is not to disable those systems blindly. First collect evidence about whether and when they override a DU command.

## What is measured

The trace records changes to:
- currentCommand;
- waypoint index/type/name;
- PATCOM_Patrol_Params;
- taskX;
- PATCOM_Group_State;
- PATCOM_Controlled;
- formation;
- behaviour;
- speed mode.

The trace uses diag_log only.

## Expected experiment

Issue one command to a real HC group, then inspect the server/RPT log:

- MOVE to an empty safe position;
- HOLD;
- REGROUP;
- FORMATION.

Repeat with:
- normal server-local AI;
- headless-client-local AI, if the mission setup moves AI locality there.

The useful result is not "it moved." The useful result is:

    DU command at t=0
    -> state A
    -> PATCOM change at t=X
    -> state B

That gives the next idea a real target.

## No intervention

Idea 04 must remain read-only.

Do not add automatic correction, waypoint deletion, PATCOM variable edits, or AI disabling here.
