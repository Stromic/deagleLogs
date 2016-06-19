/***************************************************************************************
*                                                                                      *
*                             deagleLogs - Chat Logging                                *
*                                                                                      *
***************************************************************************************/


local oConCommand = concommand.Run

function concommand.Run(ply,cmd,args)

		if !IsValid(ply) then return oConCommand(ply,cmd,args) end
		if !cmd then return oConCommand(ply,cmd,args) end

		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(ply)

		if table.HasValue(dLogs.CommandBlacklist,cmd) then
			return oConCommand(ply,cmd,args)
		end

		local tolog = {
			time=os.time(),
			steam_name=SteamName,
			name=Name,
			steam_id=SteamID,
			cmd=tostring(cmd),
			ip_address=IPAddress,
			args=util.TableToJSON(args),
			role=team.GetName(Team)
		}

		dLogs.recordLog('Command',tolog)

		return oConCommand(ply,cmd,args)

end
