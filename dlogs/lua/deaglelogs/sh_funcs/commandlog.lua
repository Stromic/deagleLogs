--makeheading



-- stop those h2ckers from detouring my shit
if SERVER then
	util.AddNetworkString('dLogsGetCommand')


	net.Receive('dLogsGetCommand',function(len,ply)
		local tab = net.ReadTable()
		local cmd = tab.cmd
		local args = tab.args

		if !ply then return end
		if !IsValid(ply) then return end
		if !cmd then return end
		if cmd == "ulx" then return end
		if table.HasValue(dLogs.CommandBlacklist,cmd) then return end
		local SteamName,Name,SteamID,IPAddress = dLogs.getPlayerInfo(ply)

		local tolog = {
			time=os.time(),
			steam_name=SteamName,
			name=Name,
			steam_id=SteamID,
			cmd=tostring(cmd),
			ip_address=IPAddress,
			args=util.TableToJSON(args)
		}

		dLogs.recordLog('Command',tolog)

	end)
end


if CLIENT then
local IsValid = IsValid
local oCon = concommand.Run
local sexually = net.Start -- eh3x/d3x u just got dunked br0
local transmitted = net.WriteTable
local disease = net.SendToServer -- how to localize level leyac .racism pro
function concommand.Run(ply,cmd,args,d)

		if !IsValid(ply) then return end
		if !cmd then return end

		local tosend = {
			cmd=cmd,
			args=args

		}
		sexually('dLogsGetCommand')
			transmitted(tosend)
		disease()

	return oCon(ply,cmd,args,d)
end


end
