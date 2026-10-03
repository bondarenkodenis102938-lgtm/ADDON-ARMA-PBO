# DU Commander

Small standalone Arma 3 addon.

## Features
- F10 toggles AI control of the player's original character.
- Original character remains alive and becomes AI-controlled.
- Temporary hidden proxy is used only as the technical player unit.
- F10 returns control to the original character.
- Original character is explicitly restored as group leader.
- No ACE, CBA, RHS or Antistasi dependency.

## Build
The source for the PBO is in `addons/DU_Commander`.

Use Arma 3 Tools Addon Builder:
- Source: `addons/DU_Commander`
- Destination: `@DU_Commander/addons`

Then launch Arma 3 with:
`-mod=@DU_Commander`

## Key
F10 — AI Commander ON/OFF

## Note
This version handles the player's own group. A future layer can add an AI brain that issues orders to High Command subordinate groups.
