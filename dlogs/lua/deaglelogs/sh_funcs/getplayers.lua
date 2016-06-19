/*************************************************
*             deagleLogs - getAdmins             *
*Retrieves all the people that can open the logs.*
*************************************************/

function dLogs.getAdmins()
	local admins = {}

	for k,v in pairs(player.GetAll()) do
		local UG = dLogs.getUserGroup(v);
		if table.HasValue( dLogs.groups.Main, UG ) then
			table.insert(admins,v)
		end
	end

	return admins
end
