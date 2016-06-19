/************************************************************************************
*                                                                                   *
*                             deagleLogs - ResetLogs                                *
*                                                                                   *
************************************************************************************/


concommand.Add(dLogs.resetCommand,
	function(ply,cmd,args)
		local category = string.lower(tostring(args[1]))
		local cats = {}
		for k,v in pairs(dLogs.max) do table.insert(cats,string.lower(tostring(k))) end

		if dLogs.canView(ply,"canReset") then
			if table.HasValue(cats,category) then
				for k,v in pairs(dLogs.Data) do
					if string.lower(k)==category then
						table.Empty(dLogs.Data[k])
					end
				end
				local query = sql.Query("DELETE FROM dlogs_"..category)

			elseif category == "all" then
				for k,v in pairs(cats) do
					local query = sql.Query("DELETE FROM dlogs_"..v)
				end

				for k,v in pairs(dLogs.Data) do
						table.Empty(dLogs.Data[k])
				end
			else
				ply:ChatPrint(category.." is not a valid log. List of valid log categories:"..tostring(table.concat(cats," | ")).." OR put 'all'")
			end
		end
	end
)


-- sql shit is to get rid of previous sql dlogs.
