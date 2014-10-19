/*
Automagically formats the first word of a player's message to be capitalized.
By: Chdata

*/

#pragma semicolon 1
#include <sourcemod>
#include <scp>

#define PLUGIN_VERSION                  "0x01"

new Handle:g_cvEnabled          = INVALID_HANDLE;
new bool:g_bEnabled             = true;

public Plugin:myinfo = {
    name = "[CFW] Capitalized First Word",
    author = "Chdata",
    description = "Capitalizes the first word of any sentence.",
    version = PLUGIN_VERSION,
    url = "http://steamcommunity.com/groups/tf2data"
};

public OnPluginStart()
{
    CreateConVar(
        "sm_cwf_version", PLUGIN_VERSION,
        "CWF Version",
        FCVAR_REPLICATED|FCVAR_PLUGIN|FCVAR_SPONLY|FCVAR_DONTRECORD|FCVAR_NOTIFY
    );

    g_cvEnabled = CreateConVar(
        "sm_cwf_enabled", "1",
        "Enables Capitalization Plugin.",
        FCVAR_PLUGIN|FCVAR_NOTIFY,
        true, 0.0, true, 1.0
    );

    AutoExecConfig(true, "plugin.cwf");

    g_bEnabled = GetConVarBool(g_cvEnabled);
    HookConVarChange(g_cvEnabled, ChangeConvar);
}

public OnConfigsExecuted()
{
    g_bEnabled = GetConVarBool(g_cvEnabled);
}

public ChangeConvar(Handle:cvConvar, const String:szOldVal[], const String:szNewVal[])
{

    g_bEnabled = GetConVarBool(g_cvEnabled);
}


public Action:OnChatMessage(&iAuthor, Handle:recipients, String:name[], String:szMessage[])
{
    if (!g_bEnabled)
    {
        return Plugin_Continue;
    }

    new i = 0; while(IsCharSpace(szMessage[i++])){}

    decl String:szWhitespace[MAXLENGTH_MESSAGE];

    strcopy(szWhitespace, i, szMessage); // Keep our whitespace c:

    new MaxMessageLength = MAXLENGTH_MESSAGE - strlen(name) - 5;

    Format(szMessage, MaxMessageLength, "%s%c%s", szWhitespace, CharToUpper(szMessage[i-1]), szMessage[i]);

    return Plugin_Changed;
}
