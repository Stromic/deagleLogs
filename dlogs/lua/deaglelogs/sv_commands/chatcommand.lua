/***************************************************************************
*                                                                          *
*                         deagleLogs - ChatCommand                         *
*                                                                          *
***************************************************************************/


hook.Add("PlayerSay",dLogs.prefix.."_chatCommand",
	function(ply,text,public)
		if (string.sub(string.lower(text), 1, string.len(dLogs.chatCommand)) == dLogs.chatCommand) then
			if table.HasValue(dLogs.getAdmins(),ply) then
				net.Start(dLogs.prefix.."_openLogs")
				net.Send(ply)

				print("["..dLogs.prefix.."] "..ply:Name().." has opened up deagleLogs!")
				return ""
			end
		end
	end
)
