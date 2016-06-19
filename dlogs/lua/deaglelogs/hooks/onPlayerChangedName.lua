/***************************************************************************************************
*                                                                                                  *
*                                 deagleLogs - Name Change Logging                                 *
*                                                                                                  *
***************************************************************************************************/


hook.Add("onPlayerChangedName",dLogs.prefix.."Name",
	function(ply,oldname,newname)
		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(ply)
		local tolog = {
			time=os.time(),
			steam_name=SteamName,
			steam_id=SteamID,
			oldname=oldname,
			newname=newname,
			ip_address=IPAddress,
			role=team.GetName(Team)
		}
		dLogs.recordLog('Name',tolog)
	end
)
