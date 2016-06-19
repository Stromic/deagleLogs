/************************************************************************************
*                                                                                   *
*                            deagleLogs - Damage Logging                            *
*                                                                                   *
************************************************************************************/

hook.Add("EntityTakeDamage","trackdmg1",
	function(ply,dmginfo)
		if !ply then return end
		if !IsValid(ply) then return end
		if !ply:IsPlayer() then return end
		if ply == nil then return end
		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(ply)
		local kSteamName,kName,kSteamID,kIPAddress,kTeam
		local weaponClass


		if IsValid(dmginfo:GetAttacker()) then
			if dmginfo:GetAttacker():IsPlayer() then
				kSteamName,kName,kSteamID,kIPAddress,kTeam = dLogs.getPlayerInfo(dmginfo:GetAttacker())

			end

			if dmginfo:GetAttacker():GetClass() == "prop_physics" then
				kSteamName,kName,kSteamID,kIPAddress,kTeam = dLogs.getPlayerInfo(dmginfo:GetAttacker())
				weaponClass=dmginfo:GetAttacker():GetClass().."("..dmginfo:GetAttacker():GetModel()..")"

			end
		end

		if IsValid(dmginfo:GetInflictor()) then
			if dmginfo:GetInflictor():IsPlayer() then
				kSteamName,kName,kSteamID,kIPAddress,kTeam = dLogs.getPlayerInfo(dmginfo:GetInflictor())
				weaponClass=dmginfo:GetInflictor():GetActiveWeapon():GetClass() or dmginfo:GetInflictor().dying_wep

			end

			if dmginfo:GetInflictor():GetClass() == "prop_physics" then
				kSteamName,kName,kSteamID,kIPAddress,kTeam = dLogs.getPlayerInfo(dmginfo:GetInflictor())
				weaponClass=dmginfo:GetInflictor():GetClass().."("..dmginfo:GetInflictor():GetModel()..")"
			end
		end
		local Damage = math.Round(dmginfo:GetDamage())


		if !weaponClass then
			if dmginfo:GetAttacker():IsWeapon() or dmginfo:GetInflictor().Projectile then
				weaponClass=dmginfo:GetAttacker():GetClass()
			end

			if dmginfo:GetInflictor():IsWeapon() or dmginfo:GetInflictor().Projectile then
				weaponClass=dmginfo:GetInflictor():GetClass()
			end
		end

		if !weaponClass then
			weaponClass=tostring(dmginfo:GetInflictor())
		end

			if dmginfo:IsFallDamage() then
				weaponClass="<something>/fall_damage"
				kSteamName,kName,kSteamID,kIPAddress,kTeam = "worldspawn","The World","","",""
			end

			local Method

			local damagetaken= ply:Health() - Damage

			if damagetaken <=0 then
				Method="KILL"
			else
				Method="DMG"
			end
			if Damage <= 0 then return end

			if !table.HasValue(dLogs.entBlacklist,weaponClass) then

				local tolog = {
				time=os.time(),
				name=Name,
				steam_name=SteamName,
				steam_id=SteamID,
				ip_address=IPAddress,
				name_killer=kName,
				steam_name_killer=kSteamName,
				steam_id_killer=kSteamID,
				ip_address_killer=kIPAddress,
				weapon=weaponClass,
				method=Method,
				damage=Damage,
				role=team.GetName(Team),
				role_killer=team.GetName(kTeam)
				}


				dLogs.recordLog('Damage',tolog)
			end

	end
)
