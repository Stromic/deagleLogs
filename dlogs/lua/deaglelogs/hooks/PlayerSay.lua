/***************************************************************************************
*                                                                                      *
*                             deagleLogs - Chat Logging                                *
*                                                                                      *
***************************************************************************************/


hook.Add("PlayerSay", dLogs.prefix.."Chat",
	function(ply, msg, teamch)

    	if !IsValid(ply) then return end
		if !msg then return end
		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(ply)

		local tolog = {
			time=os.time(),
			steam_name=SteamName,
			name=Name,
			steam_id=SteamID,
			msg=tostring(msg),
			ip_address=IPAddress,
			isteam=tostring(teamch),
			role=team.GetName(Team)
		}

		dLogs.recordLog('Chat',tolog)
	end
)
