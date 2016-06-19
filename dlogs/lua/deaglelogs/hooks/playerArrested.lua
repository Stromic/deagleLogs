/************************************************************************************
*                                                                                   *
*                            deagleLogs - Arrest Logging                            *
*                                                                                   *
************************************************************************************/


hook.Add("playerArrested",dLogs.prefix.."Arrest",
	function(target,time,officer)
		if !target then return end
		if !IsValid(target) then return end
		if !target:IsPlayer() then return end
		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(target)
		local oSteamName,oName,oSteamID,oIPAddress,oTeam = dLogs.getPlayerInfo(officer)
		local arrest_time = tostring(time)

		local actwep = target:GetWeapons()
		for k,v in pairs(actwep) do
			local d = dLogs.getWeapon(v)
			if d == dLogs.getWeapon(target:GetActiveWeapon()) then
				d =	"[ACTIVE] "..d
			end
			actwep[k] = d
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
			arrest_time=arrest_time,
			method="Arrested",
			wep=actwep,
			role=team.GetName(Team),
			orole=team.GetName(oTeam)

		}
		dLogs.recordLog('Arrest',tolog)

	end
)
