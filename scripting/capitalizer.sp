/*
    Automagically capitalizes the first word of players' messages.
    By: Chdata
*/

#pragma semicolon 1
#include <sourcemod>
#include <scp>

#define PLUGIN_VERSION "0x04"

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
    CapitalizeAll(szMessage);
    return Plugin_Changed;
}

/*
    Capitalizes the first word in a string
*/
stock Capitalize(String:szText[])
{
    new i = 0; while(IsCharSpace(szText[i])){i++;}
    szText[i] = CharToUpper(szText[i]);
}

/*
    Capitalizes the first word in a string, and the next letter after each punctuation.
    And lowercases everything else if the bool is set true.
*/
stock CapitalizeAll(String:szText[], bool:bCapitalIs = true, bool:bLowerCaseOther = false)
{
    new iLen = strlen(szText);
    new i = 0; while(IsCharSpace(szText[i])){i++;}
    szText[i] = CharToUpper(szText[i]);
    for (++i; i < iLen && szText[i] != '\0'; i++)
    {
        if (IsCharPunc(szText[i]))
        {
            i++; while(IsCharSpace(szText[i])){i++;}
            szText[i] = CharToUpper(szText[i]);
        }
        else if (bCapitalIs && szText[i] == 'i')
        {
            if ((i-1 == -1 || i+1 == iLen) || (IsCharSpace(szText[i-1]) && (IsCharByI(szText[i+1]) || (i+2 < iLen && szText[i+1] == ''' && IsCharAlpha(szText[i+2])))))
            {
                szText[i] = CharToUpper(szText[i]);
            }
        }
        else if (bLowerCaseOther)
        {
            szText[i] = CharToLower(szText[i]);
        }
    }
}

stock bool:IsCharPunc(chr)
{
    switch(chr)
    {
        case '.', '?', '!':
        {
            return true;
        }
    }
    return false;
}

stock bool:IsCharByI(chr)
{
    return IsCharPunc(chr) || IsCharSpace(chr);
}
