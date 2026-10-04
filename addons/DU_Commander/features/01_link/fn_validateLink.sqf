params [["_group", grpNull]];

if (!hasInterface) exitWith {false};
if (isNull _group) exitWith {false};

private _hcGroups = [] call DU_fnc_refresh;
if !(_group in _hcGroups) exitWith {false};

private _leader = leader _group;
if (isNull _leader) exitWith {false};
if (!alive _leader) exitWith {false};

true
