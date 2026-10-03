if (!hasInterface) exitWith {};

private _commander = missionNamespace getVariable ["DU_Commander_Original", objNull];
if (isNull _commander) exitWith {};

while {missionNamespace getVariable ["DU_Commander_Active", false]} do
{
    private _hcGroups = hcAllGroups _commander;

    {
        private _grp = _x;

        if (!isNull _grp && {count units _grp > 0} && {alive leader _grp}) then
        {
            private _leader = leader _grp;

            if (!(_grp getVariable ["DU_HC_AutoOrder", false])) then
            {
                _grp setVariable ["DU_HC_AutoOrder", true];
            };

            private _enemy = objNull;
            private _enemyDist = 2500;

            {
                if (alive _x && {side _x getFriend side _commander < 0.6} && {_x distance2D _leader < _enemyDist}) then
                {
                    _enemy = _x;
                    _enemyDist = _x distance2D _leader;
                };
            } forEach allUnits;

            private _wps = waypoints _grp;
            private _hasUsefulWP = false;

            if (count _wps > 0) then
            {
                private _current = currentWaypoint _grp;
                if (_current < count _wps) then
                {
                    private _wpPos = waypointPosition [_grp, _current];
                    if (_wpPos distance2D [0,0,0] > 1) then
                    {
                        _hasUsefulWP = true;
                    };
                };
            };

            if (!isNull _enemy) then
            {
                if (_enemyDist > 500 && {!(_leader getVariable ["DU_HC_LastAttack", false])}) then
                {
                    {deleteWaypoint _x} forEach waypoints _grp;

                    private _wp = _grp addWaypoint [getPosATL _enemy, 25];
                    _wp setWaypointType "SAD";
                    _wp setWaypointCombatMode "RED";
                    _wp setWaypointSpeed "NORMAL";
                    _wp setWaypointBehaviour "COMBAT";

                    _leader setVariable ["DU_HC_LastAttack", true];
                };
            }
            else
            {
                _leader setVariable ["DU_HC_LastAttack", false];

                if (!_hasUsefulWP) then
                {
                    private _basePos = getPosATL _commander;
                    private _angle = random 360;
                    private _radius = 300 + random 500;
                    private _patrolPos = [
                        (_basePos # 0) + (sin _angle) * _radius,
                        (_basePos # 1) + (cos _angle) * _radius,
                        0
                    ];

                    private _wp = _grp addWaypoint [_patrolPos, 50];
                    _wp setWaypointType "MOVE";
                    _wp setWaypointCombatMode "YELLOW";
                    _wp setWaypointSpeed "NORMAL";
                    _wp setWaypointBehaviour "AWARE";
                };
            };
        };
    } forEach _hcGroups;

    sleep 8;
};
