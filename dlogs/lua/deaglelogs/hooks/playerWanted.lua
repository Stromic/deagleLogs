/************************************************************************************
*                                                                                   *
*                            deagleLogs - Wanted Logging                            *
*                                                                                   *
************************************************************************************/

local hookstr = "playerWanted"

if dLogs.version != "2.5" then
	hookstr="PlayerWanted"
end

hook.Add(hookstr,dLogs.prefix.."Wanted",
	function(target,officer,reason)

		local ourtarget = target
		local ourofficer = officer

		if dLogs.version != "2.5" then
			ourtarget=officer
			ourofficer=target
		end

		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(ourtarget)
		local oSteamName,oName,oSteamID,oIPAddress,oTeam = dLogs.getPlayerInfo(ourofficer)
		local wanted_reason = tostring(reason)




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
			reason=wanted_reason,
			method="Wanted",
			role=team.GetName(Team),
			orole=team.GetName(oTeam)

		}
		dLogs.recordLog('Wanted',tolog)


	end
)
