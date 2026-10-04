# Idea 02 — native command gateway

## Current implementation

Code:
- features/02_command/fn_issueOrder.sqf
- features/02_command/fn_applyOrder.sqf

The request is created on the player's machine and executed where the current real AI leader is local.

## Important correction

The first prototype called:

    _leader commandMove _pos;

That only put the command on the leader object used as the command recipient.

The current implementation sends movement/target/attack commands to:

    units _group

This is the correct experiment for commanding the entire HC group using native unit-control commands. Bohemia's commandMove documentation defines the recipient as an Object or Array of Objects and notes that a remote command does not move the remote unit, which is why execution still happens on the leader's locality.

## Proof-of-concept orders

- MOVE
- ATTACK
- HOLD
- FORMATION
- REGROUP

No waypoint rewriting is used.

REGROUP uses commandFollow on members with the real group leader as the target. It does not mean "follow the player."

## New development instrumentation

Idea 04 starts a short read-only trace after an accepted command.

The trace records:
- currentCommand;
- current waypoint index/type/name;
- PATCOM patrol order;
- PATCOM taskX;
- PATCOM group state;
- PATCOM_Controlled;
- formation;
- behaviour;
- speed mode.

The trace does not correct anything. Its job is to prove exactly what Antistasi does after DU sends the order.
