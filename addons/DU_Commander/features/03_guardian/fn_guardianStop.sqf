if (!hasInterface) exitWith {};

DU_Guardian_Active = false;
DU_Guardian_Token = DU_Guardian_Token + 1;

private _camera = DU_Guardian_Camera;
DU_Guardian_Camera = objNull;

if (!isNull _camera) then {
    _camera cameraEffect ["TERMINATE", "BACK"];
    camDestroy _camera;
};
