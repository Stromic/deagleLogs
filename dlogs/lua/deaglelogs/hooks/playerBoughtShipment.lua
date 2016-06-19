/************************************************************************************
*                                                                                   *
*                      deagleLogs - Bought Entity Loggging                          *
*                                                                                   *
************************************************************************************/


hook.Add("playerBoughtShipment",dLogs.prefix.."Purchase",
	function(ply,entTab,ent)

		if !IsValid(ply) or !entTab then return end
		local SteamName,Name,SteamID,IPAddress,Team = dLogs.getPlayerInfo(ply)





		local tolog = {
			time=os.time(),
			steam_name=SteamName,
			name=Name,
			steam_id=SteamID,
			ip_address=IPAddress,
			item_name=entTab.name,
			price=entTab.price,
			shipment=true,
			role=team.GetName(Team)
		}
		dLogs.recordLog('Purchase',tolog)


	end
)
