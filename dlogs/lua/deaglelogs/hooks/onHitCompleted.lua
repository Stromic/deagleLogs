/*********************************************************************************************************
*                                                                                                        *
*                                   deagleLogs - Hit Completed Logging                                   *
*                                                                                                        *
*********************************************************************************************************/


hook.Add("onHitCompleted", dLogs.prefix.."HitCompleted",
	function(hitman,target,customer)

		local hSteamName,hName,hSteamID,hIPAddress,hTeam = dLogs.getPlayerInfo(hitman)
		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(target)
		local cSteamName,cName,cSteamID,cIPAddress,cTeam = dLogs.getPlayerInfo(customer)

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
			steam_name_customer = cSteamName,
			name_customer = cName,
			steam_id_customer = cSteamID,
			ip_address_customer = cIPAddress,
			method="Completed",
			hrole=team.GetName(hTeam),
			role=team.GetName(Team),
			crole=team.GetName(cTeam)
		}

		dLogs.recordLog('Hit',tolog)
	end
)
