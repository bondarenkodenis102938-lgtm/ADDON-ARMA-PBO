params [
    ["_leader", objNull, [objNull]],
    ["_group", grpNull, [grpNull]],
    ["_type", "", [""]],
    ["_pos", [], [[]]],
    ["_target", objNull, [objNull]]
];

if (isNull _leader || {!alive _leader} || {isNull _group}) exitWith {};
if !(_leader isEqualTo leader _group) exitWith {};

switch (_type) do
{
    case "MOVE":
    {
        if (_pos isEqualTo []) exitWith {};
        _leader commandMove _pos;
    };

    case "ATTACK":
    {
        if (isNull _target) exitWith {};
        _leader commandAttack _target;
    };

    case "STOP":
    {
        _leader commandStop _leader;
    };

    case "FOLLOW":
    {
        private _commander = missionNamespace getVariable ["theBoss", objNull];
        if (isNull _commander) exitWith {};
        _leader commandFollow _commander;
    };

    case "HOLD":
    {
        _leader commandStop _leader;
    };

    case "WEDGE":
    {
        _group setFormation "WEDGE";
    };

    case "LINE":
    {
        _group setFormation "LINE";
    };

    case "COLUMN":
    {
        _group setFormation "COLUMN";
    };
};
