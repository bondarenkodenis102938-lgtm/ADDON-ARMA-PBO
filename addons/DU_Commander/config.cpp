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

        class Commander
        {
            file = "du_commander\\functions";

            class init
            {
                postInit = 1;
            };

            class toggle {};
            class aiMode {};
            class takeControl {};
            class cleanup {};
        };
    };
};
