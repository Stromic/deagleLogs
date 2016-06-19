/*********************************************************************************************
*                                                                                            *
*                               deagleLogs - Warranted Logging                               *
*                                                                                            *
*********************************************************************************************/

local hookstr = "playerWarranted"

if dLogs.version != "2.5" then
	hookstr="PlayerWarranted"
end

hook.Add(hookstr,dLogs.prefix.."Warrant",
	function(target,officer,reason)

		local ourtarget = target
		local ourofficer = officer

		if dLogs.version != "2.5" then
			ourtarget=officer
			ourofficer=target
		end

		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(ourtarget)
		local oSteamName,oName,oSteamID,oIPAddress,oTeam = dLogs.getPlayerInfo(ourofficer)
		local warrant_reason = tostring(reason)




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
			reason=warrant_reason,
			method="Warranted",
			role=team.GetName(Team),
			orole=team.GetName(oTeam)

		}
		dLogs.recordLog('Warrant',tolog)
	end
)
