/************************************************************************************
*                                                                                   *
*                            deagleLogs - Demote Logging                            *
*                                                                                   *
************************************************************************************/



hook.Add("onPlayerDemoted",dLogs.prefix.."Demote",
	function(demoter,demotee,reason)
		local dSteamName,dName,dSteamID,dIPAddress,dTeam = dLogs.getPlayerInfo(demoter)
		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(demotee)
		local Reason = tostring(reason)

		local tolog = {
			time=os.time(),
			steam_name=SteamName,
			steam_id=SteamID,
			name=Name,
			ip_address=IPAddress,
			steam_name_demoter = dSteamName,
			name_demoter = dName,
			steam_id_demoter = dSteamID,
			ip_address_demoter = dIPAddress,
			reason=Reason,
			drole = team.GetName(dTeam),
			role=team.GetName(Team)
		}

		dLogs.recordLog('Demote',tolog)
	end
)
