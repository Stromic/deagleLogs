/***************************************************************************************************
*                                                                                                  *
*                                 deagleLogs - UnWarranted Logging                                 *
*                                                                                                  *
***************************************************************************************************/

local hookstr = "playerUnWarranted"

if dLogs.version != "2.5" then
	hookstr="PlayerUnWarranted"
end

hook.Add(hookstr,dLogs.prefix.."UnWarranted",
	function(target,officer)
		local ourtarget = target
		local ourofficer = officer

		if dLogs.version != "2.5" then
			ourtarget=officer
			ourofficer=target
		end

		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(ourtarget)
		local oSteamName,oName,oSteamID,oIPAddress,oTeam = dLogs.getPlayerInfo(ourofficer)

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
			method="Unwarranted",
			role=Team,
			orole=oTeam
		}
		dLogs.recordLog('Warrant',tolog)
	end
)
