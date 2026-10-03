# DU Commander

Small standalone Arma 3 addon.

## Features
- Ctrl+F10 toggles AI control of the player's original character.
- Original character remains alive and becomes AI-controlled.
- Temporary hidden proxy is used only as the technical player unit.
- Ctrl+F10 returns control to the original character.
- Original character is explicitly restored as group leader.
- When commander mode is active, High Command subordinate groups get a lightweight autonomous AI brain.
- Enemy contacts can trigger attack orders; otherwise groups receive local patrol orders.
- Static weapons such as Mk6 mortars are not moved by the HC brain.
- No ACE, CBA, RHS or Antistasi dependency.

## Build
The source for the PBO is in addons/DU_Commander.

Use Arma 3 Tools Addon Builder:
- Source: addons/DU_Commander
- Destination: @DU_Commander/addons

Then launch Arma 3 with:
-mod=@DU_Commander

## Key
Ctrl+F10 — AI Commander ON/OFF

## Notes
- The default F10 key is no longer intercepted, so it is less likely to conflict with other mods.
- The HC brain is intentionally conservative: it avoids overwriting groups already in COMBAT/STEALTH and ignores static weapons.
- Test first in a save/mission copy because HC behaviour is mission-dependent.
