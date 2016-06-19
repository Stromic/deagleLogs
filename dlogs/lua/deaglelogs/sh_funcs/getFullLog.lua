function dLogs.GetFullLog(cat,v)
	local log = ""
	if !cat or !v then return log end


	if cat == "Arrest" then
		if v.method == "Arrested" then
			log = Format([[[%s]%s(%s) arrested %s(%s) for %s seconds]],v.method,v.name_officer,v.steam_id_officer,v.name,v.steam_id,v.arrest_time)
		else
			if v.name_officer != "" then
				log = Format([[[%s]%s(%s) unarrested %s(%s)]],v.method,v.name_officer,v.steam_id_officer,v.name,v.steam_id)
			else
				log = Format([[[%s]%s(%s) was let out of jail.]],v.method,v.name,v.steam_id)
			end
		end
	end

	if cat == "Chat" then
		if v.isteam == "false" then
			log = Format([[%s(%s) said "%s"]],v.name,v.steam_id,v.msg)
		else
			log = Format([[[TEAM]%s(%s) said "%s"]],v.name,v.steam_id,v.msg)
		end
	end

	if cat == "Command" then
		log = Format([[%s(%s) entered "%s"]],v.name,v.steam_id,v.cmd.." "..table.concat(util.JSONToTable(v.args)," "))
	end

	if cat == "Connect" then
		if v.method == "Connected" then
			log = Format([[{%s}%s(%s) connected to the server.]],v.method,v.name,v.steam_id)
		else
			log = Format([[{%s}%s(%s) disconnected from the server.]],v.method,v.name,v.steam_id)
		end
	end

	if cat == "Damage" then
		if v.method == "DMG" then
			log = Format([[[%s]%s(%s) hurt %s(%s) for %s damage using %s]],v.method,v.name_killer,v.steam_id_killer,v.name,v.steam_id,tostring(v.damage),tostring(v.weapon))
		else
			log = Format([[[%s]%s(%s) killed %s(%s) with %s damage using %s]],v.method,v.name_killer,v.steam_id_killer,v.name,v.steam_id,tostring(v.damage),tostring(v.weapon))
		end
	end

	if cat == "Demote" then
		log = Format([[%s(%s) demoted %s(%s) for "%s"]],v.name_demoter,v.steam_id_demoter,v.name,v.steam_id,v.reason)
	end

	if cat=="Hit" then
		if v.method == "Accepted" then
			log = Format([[{%s}%s(%s) ordered a hit from %s(%s) on %s(%s)]],v.method,v.name_customer,v.steam_id_customer,v.name_hitman,v.steam_id_hitman,v.name,v.steam_id)
		elseif v.method == "Failed" then
			log = Format([[{%s}%s(%s) failed their hit on %s(%s) for "%s"]],v.method,v.name_hitman,v.steam_id_hitman,v.name,v.steam_id,v.reason)
		elseif v.method == "Completed" then
			log = Format([[{%s}%s(%s) completed their hit on %s(%s) ordered by %s(%s)]],v.method,v.name_hitman,v.steam_id_hitman,v.name,v.steam_id,v.name_customer,v.steam_id_customer)
		end
	end

	if cat == "Job" then
		log = Format([[%s(%s) changed their job from "%s" to "%s"]],v.name,v.steam_id,v.oldjob,v.newjob)
	end

	if cat == "Kills" then
		log = Format([[%s(%s) killed %s(%s) with %s]],v.name_killer,v.steam_id_killer,v.name,v.steam_id,v.weapon)
	end

	if cat == "Name" then
		log = Format([[%s changed their name from "%s" to "%s"]],v.steam_id,v.oldname,v.newname)
	end

	if cat == "Prop" then
		log = Format([[%s(%s) spawned a "%s"]],v.name,v.steam_id,v.model)
	end

	if cat == "Tool" then
		log = Format([[%s(%s) spawned a "%s"]],v.name,v.steam_id,v.tool)
	end

	if cat == "Wanted" then
		if v.method == "Wanted" then
			log = Format([[{%s}%s(%s) wanted %s(%s) for "%s"]],v.method,v.name_officer,v.steam_id_officer,v.name,v.steam_id,v.reason)
		else
			if v.name_officer == "_[EX]_" then
				log = Format([[{%s}%s(%s) is no longer wanted]],v.method,v.name,v.steam_id)
			end
		end
	end

	if cat == "Warrant" then
		if v.method == "Warranted" then
			log = Format([[{%s}%s(%s) warranted %s(%s) for "%s"]],v.method,v.name_officer,v.steam_id_officer,v.name,v.steam_id,v.reason)
		else
			log = Format([[{%s}%s(%s)'s warrant has expired.]],v.method,v.name,v.steam_id)
		end
	end
	return log
end
