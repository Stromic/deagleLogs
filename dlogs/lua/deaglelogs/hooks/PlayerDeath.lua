/*********************************************************************************
*                                                                                *
*                           deagleLogs - Death Logging                           *
*                                                                                *
*********************************************************************************/

hook.Add("PlayerDeath", "thisisthekilllogindeaglelogs",
	function(victim, inflictor, killer)

		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(victim)
		local kSteamName,kName,kSteamID,kIPAddress,kTeam = dLogs.getPlayerInfo(killer)
		local weaponClass = dLogs.getWeapon(inflictor)




		local tolog = {
			time=os.time(),
			steam_name=SteamName,
			name=Name,
			steam_id=SteamID,
			ip_address=IPAddress,
			steam_name_killer=kSteamName,
			name_killer=kName,
			steam_id_killer=kSteamID,
			ip_address_killer=kIPAddress,
			weapon=weaponClass,
			role=team.GetName(Team),
			role_killer=team.GetName(kTeam)

		}
		dLogs.recordLog('Kills',tolog)








	end
)
