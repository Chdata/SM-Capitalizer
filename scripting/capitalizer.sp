/*
Automagically formats the first word of a player's message to be capitalized.
By: Chdata

*/

#pragma semicolon 1
#include <sourcemod>
#include <scp>

#define PLUGIN_VERSION                  "0x02"

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
        "cv_capitalizer_version", PLUGIN_VERSION,
        "Capitalizer Version",
        FCVAR_REPLICATED|FCVAR_PLUGIN|FCVAR_SPONLY|FCVAR_DONTRECORD|FCVAR_NOTIFY
    );
}

public Action:OnChatMessage(&iAuthor, Handle:recipients, String:name[], String:szMessage[])
{
    new i = 0; while(IsCharSpace(szMessage[i++])){}

    decl String:szWhitespace[MAXLENGTH_MESSAGE];

    strcopy(szWhitespace, i, szMessage); // Keep our whitespace c:

    new MaxMessageLength = MAXLENGTH_MESSAGE - strlen(name) - 5;

    Format(szMessage, MaxMessageLength, "%s%c%s", szWhitespace, CharToUpper(szMessage[i-1]), szMessage[i]);

    return Plugin_Changed;
}
