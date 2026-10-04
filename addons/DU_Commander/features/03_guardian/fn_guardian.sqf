/*
    IDEA 03 — GUARDIAN OBSERVER

    The player remains physically in the original player unit.
    This is a detached camera only.

    Controls while DU is active:
      W/S      forward/back
      A/D      strafe
      Q/E      up/down
      Shift    fast
      Mouse    look

    F-keys, Ctrl+Space and map input remain available to native High Command.

    The camera always follows the selected group's real current leader.
    If Antistasi replaces the dead leader, DU follows the new leader without
    selecting or possessing that unit.
*/

if (!hasInterface) exitWith {};

if (isNull DU_Guardian_Camera) then {

    private _leader = leader DU_Commander_Group;
    if (isNull _leader) exitWith {};

    DU_Camera_Yaw = getDir _leader;
    DU_Camera_Pitch = -25;

    private _leaderPos = getPosASL _leader;
    DU_Camera_Position = [
        (_leaderPos # 0) - (sin DU_Camera_Yaw) * 35,
        (_leaderPos # 1) - (cos DU_Camera_Yaw) * 35,
        (_leaderPos # 2) + 25
    ];

    private _camera = "camera" camCreate DU_Camera_Position;
    _camera cameraEffect ["INTERNAL", "BACK"];
    _camera camPrepareFOV 0.75;

    DU_Guardian_Camera = _camera;

    /*
        DISPLAY objects are UI-only engine handles. Store this reference in
        uiNamespace instead of missionNamespace so Arma does not try to
        serialize it into the mission state.
    */
    uiNamespace setVariable ["DU_Guardian_Display", findDisplay 46];

    private _display = uiNamespace getVariable ["DU_Guardian_Display", displayNull];

    DU_Guardian_KeyDownEH = _display displayAddEventHandler ["KeyDown", {
        params ["_display", "_key"];

        if (!DU_Active || {visibleMap}) exitWith {false};

        switch (_key) do {
            case 0x11: {DU_Camera_Keys set ["W", true]; true};
            case 0x1E: {DU_Camera_Keys set ["A", true]; true};
            case 0x1F: {DU_Camera_Keys set ["S", true]; true};
            case 0x20: {DU_Camera_Keys set ["D", true]; true};
            case 0x10: {DU_Camera_Keys set ["Q", true]; true};
            case 0x12: {DU_Camera_Keys set ["E", true]; true};
            case 0x2A: {DU_Camera_Keys set ["SHIFT", true]; true};
            case 0x36: {DU_Camera_Keys set ["SHIFT", true]; true};
            default {false};
        };
    }];

    DU_Guardian_KeyUpEH = _display displayAddEventHandler ["KeyUp", {
        params ["_display", "_key"];

        switch (_key) do {
            case 0x11: {DU_Camera_Keys set ["W", false];};
            case 0x1E: {DU_Camera_Keys set ["A", false];};
            case 0x1F: {DU_Camera_Keys set ["S", false];};
            case 0x20: {DU_Camera_Keys set ["D", false];};
            case 0x10: {DU_Camera_Keys set ["Q", false];};
            case 0x12: {DU_Camera_Keys set ["E", false];};
            case 0x2A: {DU_Camera_Keys set ["SHIFT", false];};
            case 0x36: {DU_Camera_Keys set ["SHIFT", false];};
        };
    }];

    DU_Guardian_MouseEH = _display displayAddEventHandler ["MouseMoving", {
        params ["_display", "_dx", "_dy"];

        if (!DU_Active || {visibleMap}) exitWith {};

        DU_Camera_Yaw = (DU_Camera_Yaw + (_dx * 0.25)) % 360;
        DU_Camera_Pitch = (DU_Camera_Pitch - (_dy * 0.25)) max -85 min 85;
    }];

    DU_Guardian_MouseButtonEH = _display displayAddEventHandler ["MouseButtonDown", {
        params ["_display", "_button"];

        /*
            Do not let observer clicks fire the player's real weapon.
            In map view, allow native HC mouse interaction.
        */
        if (DU_Active && {!visibleMap} && {_button in [0,1]}) then {
            true
        } else {
            false
        };
    }];

    [_camera] spawn {
        params ["_camera"];

        while {
            DU_Active
            && {!isNull _camera}
            && {!isNull DU_Commander_Group}
        } do {

            private _group = DU_Commander_Group;

            if !(_group in (hcAllGroups player)) exitWith {
                [] call DU_fnc_remoteStop;
            };

            private _leader = leader _group;

            if (isNull _leader || {!alive _leader}) exitWith {
                [] call DU_fnc_remoteStop;
            };

            DU_Commander_Leader = _leader;

            if (!visibleMap) then {
                private _speed = if (DU_Camera_Keys getOrDefault ["SHIFT", false]) then {
                    25
                } else {
                    7
                };

                private _dt = 0.016;

                private _forward = [
                    sin DU_Camera_Yaw,
                    cos DU_Camera_Yaw,
                    0
                ];

                private _right = [
                    cos DU_Camera_Yaw,
                    -(sin DU_Camera_Yaw),
                    0
                ];

                private _move = [0,0,0];

                if (DU_Camera_Keys getOrDefault ["W", false]) then {
                    _move = _move vectorAdd _forward;
                };

                if (DU_Camera_Keys getOrDefault ["S", false]) then {
                    _move = _move vectorAdd (_forward vectorMultiply -1);
                };

                if (DU_Camera_Keys getOrDefault ["D", false]) then {
                    _move = _move vectorAdd _right;
                };

                if (DU_Camera_Keys getOrDefault ["A", false]) then {
                    _move = _move vectorAdd (_right vectorMultiply -1);
                };

                if (DU_Camera_Keys getOrDefault ["Q", false]) then {
                    _move set [2, (_move # 2) + 1];
                };

                if (DU_Camera_Keys getOrDefault ["E", false]) then {
                    _move set [2, (_move # 2) - 1];
                };

                if (_move distance [0,0,0] > 0) then {
                    _move = _move vectorMultiply (_speed * _dt);
                    DU_Camera_Position = DU_Camera_Position vectorAdd _move;
                };
            };

            private _look = [
                (cos DU_Camera_Pitch) * (sin DU_Camera_Yaw),
                (cos DU_Camera_Pitch) * (cos DU_Camera_Yaw),
                sin DU_Camera_Pitch
            ];

            private _target = DU_Camera_Position vectorAdd (_look vectorMultiply 1000);

            _camera camSetPos DU_Camera_Position;
            _camera camSetTarget _target;
            _camera camCommitPrepared 0;

            uiSleep 0.016;
        };
    };

} else {

    private _camera = DU_Guardian_Camera;
    DU_Guardian_Camera = objNull;

    private _display = uiNamespace getVariable ["DU_Guardian_Display", displayNull];

    if (!isNull _display) then {
        if (DU_Guardian_KeyDownEH >= 0) then {
            _display displayRemoveEventHandler ["KeyDown", DU_Guardian_KeyDownEH];
        };

        if (DU_Guardian_KeyUpEH >= 0) then {
            _display displayRemoveEventHandler ["KeyUp", DU_Guardian_KeyUpEH];
        };

        if (DU_Guardian_MouseEH >= 0) then {
            _display displayRemoveEventHandler ["MouseMoving", DU_Guardian_MouseEH];
        };

        if (DU_Guardian_MouseButtonEH >= 0) then {
            _display displayRemoveEventHandler ["MouseButtonDown", DU_Guardian_MouseButtonEH];
        };
    };

    if (!isNull _camera) then {
        _camera cameraEffect ["TERMINATE", "BACK"];
        camDestroy _camera;
    };

    uiNamespace setVariable ["DU_Guardian_Display", displayNull];
    DU_Guardian_KeyDownEH = -1;
    DU_Guardian_KeyUpEH = -1;
    DU_Guardian_MouseEH = -1;
    DU_Guardian_MouseButtonEH = -1;
    DU_Camera_Keys = createHashMap;
};
