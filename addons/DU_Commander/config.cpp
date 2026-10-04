class CfgPatches
{
    class DU_Commander
    {
        name = "DU Commander";
        author = "DU";
        requiredVersion = 2.10;
        requiredAddons[] = {"A3_Functions_F"};
        units[] = {};
        weapons[] = {};
    };
};

class CfgFunctions
{
    class DU
    {
        tag = "DU";

        class Core
        {
            file = "\du_commander\functions";
            class init { postInit = 1; };
            class toggle {};
            class refresh {};
        };

        class RemoteHC
        {
            file = "\du_commander\features\01_remote_hc";
            class remoteStart {};
            class remoteStop {};
        };

        class NativeHC
        {
            file = "\du_commander\features\02_native_hc";
            class nativePrepare {};
        };

        class Guardian
        {
            file = "\du_commander\features\03_guardian";
            class guardian {};
        };

        class Selection
        {
            file = "\du_commander\features\04_selection";
            class onSelectionChanged {};
        };
    };
};
