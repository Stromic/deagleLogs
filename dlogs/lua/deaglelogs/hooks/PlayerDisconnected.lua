hook.Add("PlayerDisconnected", dLogs.prefix.."Disconnect", 
	function(ply)
		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(ply)

		local tolog = {
			time=os.time(),
			steam_name=SteamName,
			name=Name,
			steam_id=SteamID,
			ip_address=IPAddress,
			method="Disconnected",
			role=team.GetName(Team)
		}

		dLogs.recordLog('Connect',tolog)
	end
)
