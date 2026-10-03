# DU Commander

Standalone Arma 3 addon for Antistasi Ultimate tactical control.

## Concept

Antistasi remains the AI and High Command brain.

DU Commander does not create its own HC brain, enemy scanner, patrol system, or waypoint manager.

When Ctrl+F10 is pressed:

1. Your real commander body remains alive in the world.
2. The real body is left under normal Arma/Antistasi AI control.
3. DU creates only a temporary technical player proxy.
4. The player switches into the proxy and enters Arma's native End Game Spectator free-camera mode.
5. From the ghost camera, the player can issue tactical orders to the original commander's group.
6. Ctrl+F10 terminates spectator mode, deletes the technical proxy, and returns the player to the real commander.

## Tactical ghost commands

While the ghost mode is active:

- Ctrl+1 — AUTO stance
- Ctrl+2 — everyone DOWN
- Ctrl+3 — everyone UP
- Ctrl+4 — WEDGE
- Ctrl+5 — LINE
- Ctrl+6 — COLUMN
- Ctrl+7 — HOLD FIRE
- Ctrl+8 — FIRE AT WILL
- Ctrl+9 — ENGAGE AT WILL
- Ctrl+0 — HOLD FIRE / ENGAGE AT WILL

The commands operate on the original commander's existing group. DU does not create or manage High Command groups.

## Antistasi compatibility

Antistasi Ultimate already has an experimental AI Possession feature and a High Command Transfer feature. DU Commander is intentionally designed as a lightweight addon layer instead of replacing those systems.

Important: the temporary player proxy is a technical implementation detail. The real commander unit is never deleted or replaced.

## Build

The source for the PBO is in addons/DU_Commander.

Use Arma 3 Tools Addon Builder:

- Source: addons/DU_Commander
- Destination: @DU_Commander/addons

Launch Arma 3 with:

-mod=@DU_Commander

## Current status

Prototype / first implementation of Tactical Ghost mode. Test in a copy of an Antistasi save first, especially in multiplayer, because selectPlayer changes locality and player identity handling in Arma.
