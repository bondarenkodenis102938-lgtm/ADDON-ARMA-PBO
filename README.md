# DU Commander — clean rewrite

Thin Arma 3 addon for Antistasi Ultimate.

Rules:
- player stays in the player's own body;
- no selectPlayer;
- no proxy unit;
- no second AI commander;
- no generic waypoint deletion;
- no replacement of Antistasi PATCOM;
- link only to existing High Command groups;
- execute native orders on the locality of the real AI leader;
- Guardian is camera-only.

Implementation is split by idea:
- features/01_link
- features/02_command
- features/03_guardian

The UI comes after the low-level contract is verified.

See docs/AI_HANDOFF.md for the next AI's working instructions.
