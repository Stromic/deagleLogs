--makeheading



net.Receive(dLogs.prefix.."_getData",function(len,ply)

	local logType = net.ReadString()
	local logAmount = net.ReadInt(32)
	local pageid = net.ReadInt(32)


	if !dLogs.canView(ply,logType) then return end

	local data = dLogs.Data[logType].Page[pageid]

	if !data then ply:ChatPrint("Data was nil for "..logType.." report this to Deagler if this happens") return end

	data = dLogs.parseIPs(ply,data)

	net.Start(dLogs.prefix.."_send"..string.lower(logType).."Data")
		net.WriteString(logType)
		net.WriteString(util.TableToJSON(data))
		net.WriteInt(pageid,32)
		net.WriteInt(table.Count(dLogs.Data[logType].Page),32)
	net.Send(ply)

end)


--[[
net.Receive(dLogs.prefix.."_getSearchData",function(len,ply)

	local logType = net.ReadString()
	local logAmount = net.ReadInt(32)
	local searchVariable = net.ReadString()
	local searchValue = net.ReadString()

	if !dLogs.canView(ply,logType) then return end

	local searchData = dLogs.GetSpecificSQL(logType,logAmount,searchVariable,searchValue)

	if !searchData then
		ply:ChatPrint("No Results for the search "..searchValue)
		return
	end

	searchData = dLogs.parseIPs(ply,searchData)

	net.Start(dLogs.prefix.."_send"..string.lower(logType).."Data")
		net.WriteString(logType)
		net.WriteString(util.TableToJSON(searchData))
	net.Send(ply)



end) ]]
