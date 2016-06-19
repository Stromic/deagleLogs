/***************************************************************************************
*                                                                                      *
*                             deagleLogs - Connect Logging                             *
*                                                                                      *
***************************************************************************************/


hook.Add("PlayerInitialSpawn", dLogs.prefix.."Connect",
	function(ply)
		timer.Simple(3,function()
			local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(ply)

			local tolog = {
				time=os.time(),
				steam_name=SteamName,
				name=Name,
				steam_id=SteamID,
				ip_address=IPAddress,
				method="Connected",
				role=team.GetName(Team)
			}

			dLogs.recordLog('Connect',tolog)
		end)
	end
)
