/************************************************************
*                                                           *
*                    deagleLogs - Loader                    *
*                                                           *
************************************************************/
dLogs = dLogs or {}
dLogs.prefix = "deagleLogs" -- dont remove kent

if SERVER then
util.AddNetworkString(dLogs.prefix.."_openLogs")
util.AddNetworkString(dLogs.prefix.."_getData")
util.AddNetworkString(dLogs.prefix.."_getSearchData")


end

function dLogs.Print(str)
	if SERVER or CLIENT then
		if type(str) != "table" then
			MsgN("["..dLogs.prefix.."] "..tostring(str))
		else
			for k,v in ipairs(str) do
				MsgN("["..dLogs.prefix.."] "..tostring(k).."\t"..tostring(v))
			end
		end
	end
end



function dLogs.EasyInclude(sFolderName,sLoadType,sName)

	local path = "deaglelogs/"

	if !sLoadType or !sFolderName or !sName then dLogs.Print("Error: Include Failed\tFolder: "..tostring(sFolderName).."\tLua State: "..tostring(sLoadType).."\tName: "..tostring(sName)) return end

	path = path..sFolderName

	local toload = file.Find(path.."/*.lua","LUA")


	if SERVER then

		if sLoadType == "sv" then

			for k,v in ipairs(toload) do
				dLogs.Print(sName.." Serverside File: "..v)
				include(path.."/"..v)
			end

		elseif sLoadType == "sh" then
			for k,v in ipairs(toload) do
				dLogs.Print(sName.." Shared File: "..v)

				include(path.."/"..v)
				AddCSLuaFile(path.."/"..v)
			end
		elseif sLoadType == "cl" then
			for k,v in ipairs(toload) do
				dLogs.Print(sName.." Clientside File: "..v)
				AddCSLuaFile(path.."/"..v)
			end
		end

	elseif CLIENT then

		if sLoadType == "sh" then
			for k,v in ipairs(toload) do
				dLogs.Print(sName.." Shared File: "..v)
				include(path.."/"..v)
			end
		elseif sLoadType == "cl" then
			for k,v in ipairs(toload) do
				dLogs.Print(sName.." Clientside File: "..v)
				include(path.."/"..v)
			end

		end

	end

end

local function includeall()
dLogs.EasyInclude("config","sh","Setting up")
dLogs.EasyInclude("sh_funcs","sh","Creating")
dLogs.EasyInclude("sv_funcs","sv","Creating")
dLogs.EasyInclude("categories","sh","Adding")
dLogs.EasyInclude("data","sv","Hacking")
dLogs.EasyInclude("sv_commands","sv","Making")
dLogs.EasyInclude("vgui","cl","Building")
dLogs.EasyInclude("hooks","sv","Hooking")

hook.Remove("Think","theulxishacked")
end

hook.Add("Think","theulxishacked",function()
	if ulx then
		includeall()
	end
end)
