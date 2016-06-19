--makeheading

function dLogs.parseIPs(ply,tab)
	for k,v in pairs(tab) do
		for k2,v2 in pairs(v) do
			if !dLogs.canView(ply,"IP") and string.find(string.lower(k2),'ip') then
				tab[k][k2] = "IP Blocked, Not in correct group?"
			elseif dLogs.canView(ply,"IP") and string.find(string.lower(k2),'ip') then
				local x = string.find(tab[k][k2],":")
				if (x) then
						tab[k][k2] = string.sub(tab[k][k2],0,x-1)
				end
			end


		end
	end

	return tab

end
