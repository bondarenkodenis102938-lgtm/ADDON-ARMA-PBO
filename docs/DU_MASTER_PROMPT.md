# DU Commander — master prompt

You are maintaining DU Commander.

## The user's actual goal

The user wants the existing Antistasi Ultimate Control HC Squad experience, but with one difference:

Antistasi:
the player is transferred into the real AI leader.

DU:
the player stays in the player's own body and controls/observes the real AI group from a detached camera.

## Required runtime model

PLAYER BODY
  -> DU Remote HC session
  -> existing Antistasi HC group
  -> real AI leader
  -> native Arma High Command
  -> Antistasi AI / PATCOM

## Hard rules

Never:
- call selectPlayer from DU;
- create a proxy unit;
- create a replacement AI commander;
- create a second AI brain;
- copy the native High Command command menu;
- replace native HC commands with a custom MOVE/ATTACK/HOLD gateway;
- disable PATCOM just to make DU easier;
- delete Antistasi waypoints just to take control.

## What DU is

DU is a presentation/control bridge around native High Command.

The player is already the Antistasi commander. DU gives that commander a detached observer camera while native HC continues to issue the orders.

## Final UX

Ctrl+F10:
- start/stop Remote HC.

On start:
1. require player == theBoss;
2. find the already exposed HC groups;
3. select one real AI group;
4. enable native HC;
5. start detached Guardian camera.

While active:
- player body remains unchanged;
- AI group remains unchanged;
- native F-key HC selection works;
- native map commands work;
- native command menu works;
- Antistasi AI keeps reacting to the battlefield;
- Guardian camera follows the currently selected real AI leader.

On stop:
- destroy only the camera;
- restore the HC bar presentation;
- do not touch group leader/ownership/waypoints/Antistasi AI.

## Critical design boundary

DU cannot make the engine literally treat the player's physical body as the AI group's squad leader without changing group/player identity.

The requested no-possession behavior is therefore implemented using the engine-supported High Command commander model: the player commands the real AI group as a remote commander while observing through the camera.

## Development discipline

Inspect the Antistasi reference branch before inventing behavior.

Use exact Antistasi source paths.

Record why every significant function exists.

If a behavior has not been tested in-game, label it untested.
