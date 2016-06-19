/************************************************************************************************
*                                                                                               *
*                                deagleLogs - Hit Failed Logging                                *
*                                                                                               *
************************************************************************************************/


hook.Add("onHitFailed", dLogs.prefix.."HitFailed",
	function(hitman,target,reason)

		local hSteamName,hName,hSteamID,hIPAddress,hTeam = dLogs.getPlayerInfo(hitman)
		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(target)
		local Reason = tostring(reason)

		local tolog = {
			time=os.time(),
			steam_name=SteamName,
			steam_id=SteamID,
			name=Name,
			ip_address=IPAddress,
			steam_name_hitman = hSteamName,
			name_hitman = hName,
			steam_id_hitman = hSteamID,
			ip_address_hitman = hIPAddress,
			reason=Reason,
			method="Failed",
			hrole=team.GetName(hTeam),
			role=team.GetName(Team)
		}

		dLogs.recordLog('Hit',tolog)
	end
)
