params [["_leader", objNull]];

if (!hasInterface) exitWith {false};
if (isNull _leader) exitWith {false};
if (!alive _leader) exitWith {false};
if (DU_Guardian_Active) exitWith {true};

DU_Guardian_Token = DU_Guardian_Token + 1;
private _token = DU_Guardian_Token;

private _camera = "camera" camCreate ((getPosASL _leader) vectorAdd [20, 20, 30]);
_camera cameraEffect ["INTERNAL", "BACK"];
_camera camPrepareFOV 0.7;
_camera camPrepareTarget _leader;
_camera camCommitPrepared 0;

DU_Guardian_Camera = _camera;
DU_Guardian_Active = true;

[_leader, _camera, _token] spawn {
    params ["_leader", "_camera", "_token"];
    private _angle = 45;
    private _radius = 35;
    private _altitude = 25;

    while {
        DU_Guardian_Active
        && {DU_Guardian_Token isEqualTo _token}
        && {!isNull _leader}
        && {alive _leader}
        && {!isNull _camera}
    } do {
        private _center = getPosASL _leader;

        private _pos = [
            (_center # 0) + (sin _angle) * _radius,
            (_center # 1) + (cos _angle) * _radius,
            (_center # 2) + _altitude
        ];

        _camera camPreparePos _pos;
        _camera camPrepareTarget _leader;
        _camera camCommitPrepared 0.08;

        _angle = (_angle + 0.8) % 360;
        uiSleep 0.08;
    };
};

true
