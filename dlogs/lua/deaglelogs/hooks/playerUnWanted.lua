/******************************************************************************************
*                                                                                         *
*                              deagleLogs - UnWanted Logging                              *
*                                                                                         *
******************************************************************************************/

local hookstr = "playerUnWanted"

if dLogs.version != "2.5" then
	hookstr="PlayerUnWanted"
end

hook.Add(hookstr,dLogs.prefix.."UnWanted",
	function(target,officer)

		local ourtarget = target
		local ourofficer = officer

		if dLogs.version != "2.5" then
			ourtarget=officer
			ourofficer=target
		end
		local SteamName,Name,SteamID,IPAddress,Team
		local oSteamName,oName,oSteamID,oIPAddress,oTeam

		SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(ourtarget)

		if officer then
			oSteamName,oName,oSteamID,oIPAddress,oTeam = dLogs.getPlayerInfo(ourofficer)
		else
			oSteamName,oName,oSteamID,oIPAddress,oTeam = "_[EX]_","_[EX]_","_[EX]_","_[EX]_","_[EX]_"
		end

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
			method="Unwanted",
			role=team.GetName(Team),
			orole=team.GetName(oTeam)
		}
		dLogs.recordLog('Wanted',tolog)

	end
)
