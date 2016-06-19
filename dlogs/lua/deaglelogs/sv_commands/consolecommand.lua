/************************************************************************************
*                                                                                   *
*                            deagleLogs - ConsoleCommand                            *
*                                                                                   *
************************************************************************************/


concommand.Add(dLogs.consoleCommand,
	function(ply,cmd,args)
		if table.HasValue(dLogs.getAdmins(),ply) then
			net.Start(dLogs.prefix.."_openLogs")
			net.Send(ply)
		end
	end
)
