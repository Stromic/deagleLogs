/********************************************************************
*                       deagleLogs - RecordLog                      *
*This function sends a table/log to everyone that can open the menu.*
********************************************************************/

dLogs.Data = dLogs.Data or {}
dLogs.Data.Name = dLogs.Data.Name or {}
dLogs.Data.Job = dLogs.Data.Job or {}
dLogs.Data.Kills = dLogs.Data.Kills or {}
dLogs.Data.Prop = dLogs.Data.Prop or {}
dLogs.Data.Tool = dLogs.Data.Tool or {}
dLogs.Data.Connect = dLogs.Data.Connect or {}
dLogs.Data.Damage = dLogs.Data.Damage or {}
dLogs.Data.Arrest = dLogs.Data.Arrest or {}
dLogs.Data.Demote = dLogs.Data.Demote or {}
dLogs.Data.Hit = dLogs.Data.Hit or {}
dLogs.Data.Warrant = dLogs.Data.Warrant or {}
dLogs.Data.Wanted = dLogs.Data.Wanted or {}
dLogs.Data.Purchase = dLogs.Data.Purchase or {}
dLogs.Data.Chat = dLogs.Data.Chat or {}
dLogs.Data.Command = dLogs.Data.Command or {}

for k,v in pairs(dLogs.Data) do -- set up page tables.

dLogs.Data[k].Page = {}
dLogs.Data[k].Page[1] = {}
end


local function SetupFolderPaths()
	print('settin up folder pths')
	if !file.Exists("dlogs_logs","DATA") then
		file.CreateDir('dlogs_logs')
	end

	for k,v in pairs(dLogs.Data) do
		if !file.Exists("dlogs_logs/"..string.lower(k),"DATA") then
			file.CreateDir('dlogs_logs/'..string.lower(k))
		end
	end


end

local function SaveLog(log,data)
	if !data then return end
	if !data.time then return end
	local currentday = os.date("%d.%m.%Y",data.time)
	local ourfile = "dlogs_logs/"..string.lower(log).."/"..currentday..".txt"

	if !file.Exists(ourfile,"DATA") then

		file.Write(ourfile,"deagleLogs - "..log.. " Logs Serverside Saving\n"..os.date("%x",data.time).."\n==============================================\n\n")
		local format = dLogs.GetFullLog(log,data)
		format = os.date("%I:%M:%S %p",data.time).."\t\t"..format

		file.Append(ourfile,"\n"..format)
	else
		local format = dLogs.GetFullLog(log,data)
		format = os.date("%I:%M:%S %p",data.time).."\t\t"..format
		file.Append(ourfile,"\n"..format)
	end

end

local function FixItAllUpYo(log,allowedcount) -- when u have other stuff to do and people beg u to add more stuff to dlogs.
	for k,v in pairs(dLogs.Data) do
		for i=1,table.Count(dLogs.Data[k].Page) do

			local count = table.Count(dLogs.Data[k].Page[i])


			if count > allowedcount then
				if i != 10 then
					if !dLogs.Data[k].Page[i+1] then
						dLogs.Data[k].Page[i+1] = {}
					end

					table.insert(dLogs.Data[k].Page[i+1],1,dLogs.Data[k].Page[i][count])
					table.remove(dLogs.Data[k].Page[i],count)
				else
					table.remove(dLogs.Data[k].Page[i],count)
				end
			end

		end

	end

end


function dLogs.recordLog(log,data)

	table.insert(dLogs.Data[log].Page[1],1,data)

	local count = table.Count(dLogs.Data[log])
	SaveLog(log,data)
	local allowedcount_perpage = math.Round(dLogs.max[log]/10)
	FixItAllUpYo(log,allowedcount_perpage);

--[[
	net.Start(dLogs.prefix.."_sendLogs")
		net.WriteTable(log)
	net.Send(dLogs.getAdmins())
]]--
end


SetupFolderPaths()
