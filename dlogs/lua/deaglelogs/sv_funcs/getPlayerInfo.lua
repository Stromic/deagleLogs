/*************************************
*                                    *
*     deagleLogs - getPlayerInfo     *
*                                    *
*************************************/

function dLogs.getPlayerInfo(ply)
	local SteamName = ""
	local Name = ""
	local SteamID = ""
	local IPAddress = ""
	local Team = ""
	if IsValid(ply) and ply then
		if ply:IsPlayer() then
			SteamName = ply.SteamName and ply:SteamName() or "ERROR_S_NAME"
			Name      = ply.Name and ply:Name() or "ERROR_NAME"
			SteamID   = ply.SteamID and ply:SteamID() or "ERROR_STEAMID"
			IPAddress = ply.IPAddress and ply:IPAddress() or "ERROR_IP"
			Team      = ply.Team and ply:Team() or "ERROR_TEAM"

			return SteamName,Name,SteamID,IPAddress,Team
		end

		if ply:GetClass() == "prop_physics" and ply.CPPIGetOwner then
			ply = ply:CPPIGetOwner()
			if !ply then
			SteamName = "Unknown Player"
			Name      = "Unknown Player"
			SteamID   = "n/a"
			IPAddress =  "Unknown IP"
			Team      =  "n/a"

			return SteamName,Name,SteamID,IPAddress,Team
			end
			SteamName = ply.SteamName and ply:SteamName() or "ERROR_S_NAME"
			Name      = ply.Name and ply:Name() or "ERROR_NAME"
			SteamID   = ply.SteamID and ply:SteamID() or "ERROR_STEAMID"
			IPAddress = ply.IPAddress and ply:IPAddress() or "ERROR_IP"
			Team      = ply.Team and ply:Team() or "ERROR_TEAM"

			return SteamName,Name,SteamID,IPAddress,Team
		else
			SteamName = ply.GetClass and ply:GetClass() or "ERROR_NOENT"
			Name      = ply.GetPrintName and ply:GetPrintName() or "<something>"
			SteamID   = ""
			IPAddress = ""
			Team = ply.GetClass and ply:GetClass() or "ERROR_NOENT"
			return SteamName,Name,SteamID,IPAddress,Team
		end
	end

	return SteamName,Name,SteamID,IPAddress,Team

end
