--make heading

function dLogs.getUserGroup(ply)
	local UG = ply:GetNWString("UserGroup");

	if (serverguard) then UG = serverguard.player:GetRank(ply); end
	if (ply.EV_GetRank) then UG = ply:EV_GetRank(); end

	return ( UG );
end
