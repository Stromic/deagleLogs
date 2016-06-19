/************************************************************************************************
*                                                                                               *
*                                deagleLogs - Prop Spawn Logging                                *
*                                                                                               *
************************************************************************************************/



hook.Add("PlayerSpawnProp", dLogs.prefix.."Prop",
	function(ply, class)
		if !IsValid(ply) then return end
		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(ply)

		local tolog = {
			time=os.time(),
			steam_name=SteamName,
			steam_id=SteamID,
			model=class,
			name=Name,
			ip_address=IPAddress,
			role=team.GetName(Team)
		}
		dLogs.recordLog('Prop',tolog)
	end
)
