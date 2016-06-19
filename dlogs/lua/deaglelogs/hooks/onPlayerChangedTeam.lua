hook.Add("OnPlayerChangedTeam", dLogs.prefix.."Job", 
	function(ply, oldteam, newteam)
		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(ply)

		local tolog = {
			time=os.time(),
			steam_name=SteamName,
			name=Name,
			steam_id=SteamID,
			oldjob=team.GetName(oldteam),
			newjob=team.GetName(newteam),
			ip_address=IPAddress,
			role=team.GetName(Team)
		}
		dLogs.recordLog('Job',tolog)
	end
)
