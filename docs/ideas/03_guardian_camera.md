# Idea 03 — Guardian camera

Antistasi Ultimate already contains:
- A3A/addons/scrt/Misc/fn_misc_orbitingCamera.sqf
- A3A/addons/scrt/Misc/fn_misc_followCamera.sqf

Those helpers target player. DU cannot reuse them unchanged because the Guardian target is an AI leader.

The DU proof uses the same camera concept around the real AI leader:
- camera object only;
- no player transfer;
- no hidden replacement unit;
- clean camera termination.

Current limitation: orbit proof only. Free-flight controls are a later idea.
