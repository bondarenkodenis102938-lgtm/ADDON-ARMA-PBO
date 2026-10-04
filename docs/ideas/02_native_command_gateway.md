# Idea 02 — native command gateway

Code:
- features/02_command/fn_issueOrder.sqf
- features/02_command/fn_applyOrder.sqf

A player-side request is separated from the actual command execution. The packet is executed where the current real AI leader is local.

Proof-of-concept orders:
- MOVE
- ATTACK
- HOLD
- FORMATION
- REGROUP

No waypoint rewriting is used.

REGROUP uses commandFollow on members with their own leader as the follow target. It does not pretend commandFollow can continuously follow the player.
