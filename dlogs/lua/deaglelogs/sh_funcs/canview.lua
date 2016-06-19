--make heading

function dLogs.canView(ply,category)
	local UG = dLogs.getUserGroup(ply);

	if !dLogs.groups[category] then return end
	if !table.HasValue( dLogs.groups[category] , "*" ) then
		if table.HasValue( dLogs.groups[category] , UG ) then
			return true
		end
	else
		if table.HasValue( dLogs.getAdmins() , ply ) then
			return true
		end
	end

	return false

end
