--Make a heading

dLogs.Menus = dLogs.Menus or {}
dLogs.SQL = dLogs.SQL or {}
dLogs.SQL.Tables = dLogs.SQL.Tables or {}


function dLogs.AddMenu(tLog)
	if CLIENT then
		if tLog.Disabled then
			dLogs.Print(tLog.Name.." was disabled and was not added to the "..dLogs.prefix.." menu")
			return
		end


		if dLogs.canView(LocalPlayer(),tLog.RawName) == false then
			dLogs.Print("Sorry, You do not have access to "..tLog.Name.." and it isn't being logged :(")
			return
		end



		local Order = tLog.Order or ( table.Count(dLogs.Menus) + 1 )

		dLogs.Menus[Order] = tLog


		dLogs.Print(tLog.Name.." was registered and is now being logged")
	else

		util.AddNetworkString(dLogs.prefix.."_send"..string.lower(tLog.RawName).."Data")
	end

end

-- idk why i put the command here, I just did for now. I'll move it later to coincide with my habit of creating 100 files.
	concommand.Add("dlogs",function(ply,cmd,args)
		if !args[1] then
		return
		end

		for k,v in pairs(dLogs.Menus) do
				if v.Panel and !v.Panel.Windowed then
					dLogs.Menus[k].Panel:Remove()

					if v.ListView then
						dLogs.Menus[k].ListView = nil
					end
					if v.minimalSearch then
						dLogs.Menus[k].minimalSearch = nil
					end

				end
		end
		for k,v in pairs(dLogs.Menus) do
			if args[1] == v.RawName then
				v.MakePanel()
			end
		end


	end)

	function dLogs.GetCurrentTab()

		for k,v in pairs(dLogs.Menus) do
			if v.Panel then
				if v.Panel:IsVisible() then
					return v.Name
				end
			end
		end

		return
	end
