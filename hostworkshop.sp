#include <sourcemod>

public Plugin myinfo =
{
	name = "Host Workshop Map",
	author = "Ali",
	description = "Hosts a map on the workshop on a server",
	version = "1.0",
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_hostworkshop", Command_Hostworkshop, "sm_rcon host_workshop_map <args>");
}

public Action Command_Hostworkshop(int client, int args)
{
	if (args < 1)
	{
		ReplyToCommand(client, "[SM] Usage: sm_hostworkshop <args>");
		return Plugin_Handled;
	}
	
	char argstring[255];
	GetCmdArgString(argstring, sizeof(argstring));
	if(StrContains(argstring, ";") != -1)
	{
		ReplyToCommand(client, "[SM] Usage: sm_hostworkshop <args>. Must be numerical.");
		return Plugin_Handled;
	}
	
	if(StringToInt(argstring) == 0)
	{
		ReplyToCommand(client, "[SM] Usage: sm_hostworkshop <args>. Must be numerical.");
		return Plugin_Handled;
	}
	
	
	
	
	LogAction(client, -1, "\"%L\" console command (cmdline \"host_workshop_map %d\")", client, StringToInt(argstring));

	if (client == 0) 
	{
		ServerCommand("host_workshop_map %d", StringToInt(argstring));
	} else {
		char responseBuffer[4096];
		ServerCommandEx(responseBuffer, sizeof(responseBuffer), "host_workshop_map %d", StringToInt(argstring));
		ReplyToCommand(client, responseBuffer);
	}

	return Plugin_Handled;

}