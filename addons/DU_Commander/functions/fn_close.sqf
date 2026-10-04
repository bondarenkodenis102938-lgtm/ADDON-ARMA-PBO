if (!hasInterface) exitWith {};

[] call DU_fnc_guardianStop;

private _group = DU_Commander_Group;
if (!isNull _group) then {
    if ((_group getVariable ["DU_LinkOwnerUID", ""]) isEqualTo (getPlayerUID player)) then {
        _group setVariable ["DU_LinkOwnerUID", "", true];
    };
};

DU_Active = false;
DU_HC_GROUPS = [];
DU_Commander_Group = grpNull;
DU_Commander_Leader = objNull;
DU_Link_UID = "";

hintSilent "DU Commander: link released.";
