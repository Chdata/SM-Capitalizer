/*
    Automagically capitalizes the first word of players' messages.
    By: Chdata
*/

#pragma semicolon 1
#include <sourcemod>
#include <scp>

#define PLUGIN_VERSION "0x03"

public Plugin:myinfo = {
    name = "Capitalized First Word",
    author = "Chdata",
    description = "Capitalizes the first word of any sentence.",
    version = PLUGIN_VERSION,
    url = "http://steamcommunity.com/groups/tf2data"
};

public OnPluginStart()
{
    CreateConVar("cv_capitalizer_version", PLUGIN_VERSION, "Capitalizer Version", FCVAR_NOTIFY|FCVAR_DONTRECORD|FCVAR_CHEAT);
}

public Action:OnChatMessage(&iAuthor, Handle:hRecipients, String:szName[], String:szMessage[])
{
    Capitalize(szMessage);
    return Plugin_Changed;
}

stock Capitalize(String:szText[])
{
    new i = 0; while(IsCharSpace(szText[i])){i++;}
    szText[i] = CharToUpper(szText[i]);
}
