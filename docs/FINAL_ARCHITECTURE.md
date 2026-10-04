# DU Commander — final architecture

## User experience

Ctrl+F10 enters Remote HC Observer.

The player remains in the original player unit.

The selected HC group remains the original Antistasi group.

The selected group leader remains the actual AI leader.

## Control

All command actions come from native Arma High Command.

DU does not recreate:
- Move;
- Target;
- Attack;
- Stop;
- Formation;
- waypoint editing;
- command hierarchy.

The player uses native HC mode, F-key group selection and map interaction.

## Observation

A detached local camera provides the god-like observer view.

The camera:
- can move freely;
- can rotate with the mouse;
- can change elevation;
- follows the real selected AI leader when HC selection changes.

## Antistasi

Antistasi remains the owner of:
- HC group lifecycle;
- AI behavior;
- PATCOM;
- attack drill AI;
- group waypoints;
- combat decisions.

DU only observes and exposes native control.

## Multiplayer

The remote commander session is restricted to the same commander role used by Antistasi's built-in HC control path: player == theBoss.

No group locality transfer is performed by DU.

## Why this is different from the discarded prototype

The discarded prototype recreated commandMove/commandAttack/etc.

That was the wrong abstraction.

The final implementation does not care how Antistasi or native HC realizes a command. It simply keeps the player in High Command and moves the viewpoint away from the body.
