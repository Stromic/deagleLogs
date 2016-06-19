/***************************************************************************************
*                                                                                      *
*                             deagleLogs - ToolGun Logging                             *
*                                                                                      *
***************************************************************************************/


hook.Add("CanTool", dLogs.prefix.."Tool",
	function(ply, tr, toolclass)

    	if !IsValid(ply) then return end

		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(ply)

		local tolog = {
			time=os.time(),
			steam_name=SteamName,
			name=Name,
			steam_id=SteamID,
			tool=toolclass,
			ip_address=IPAddress,
			role=team.GetName(Team)
		}

		dLogs.recordLog('Tool',tolog)
	end
)
