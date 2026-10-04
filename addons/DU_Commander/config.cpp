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
            class close {};
            class refresh {};
        };

        class Idea01_Link
        {
            file = "\du_commander\features\01_link";
            class linkToGroup {};
            class validateLink {};
        };

        class Idea02_Command
        {
            file = "\du_commander\features\02_command";
            class issueOrder {};
            class applyOrder {};
        };

        class Idea03_Guardian
        {
            file = "\du_commander\features\03_guardian";
            class guardianStart {};
            class guardianStop {};
        };

        class Idea04_Diagnostics
        {
            file = "\du_commander\features\04_diagnostics";
            class traceOrder {};
        };
    };
};

class CfgRemoteExec
{
    class Functions
    {
        mode = 2;
        jip = 0;

        class DU_fnc_applyOrder
        {
            allowedTargets = 0;
            jip = 0;
        };
    };
};
