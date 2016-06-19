/******************************************************************************************
*                                                                                         *
*                              deagleLogs - UnArrest Logging                              *
*                                                                                         *
******************************************************************************************/

hook.Add("playerUnArrested",dLogs.prefix.."UnArrested",
	function(target,officer)
		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(target)
		local oSteamName,oName,oSteamID,oIPAddress,oTeam = dLogs.getPlayerInfo(officer)

		local tolog = {
			time=os.time(),
			steam_name=SteamName,
			name=Name,
			steam_id=SteamID,
			ip_address=IPAddress,
			steam_name_officer=oSteamName,
			name_officer=oName,
			steam_id_officer=oSteamID,
			ip_address_officer=oIPAddress,
			method="Unarrested",
			role=team.GetName(Team),
			orole=team.GetName(oTeam)

		}
		dLogs.recordLog('Arrest',tolog)

	end
)
