--makeheading

net.Receive(dLogs.prefix.."_openLogs", function()
	dLogs.dFrame = vgui.Create("LogFrame")
	dLogs.dFrame:AddTabs()
end)


local function SetupFilePaths() -- lol just cuz its here its here, deal with it
	print('Setting up folder paths.')
	if !file.Exists("dlogs_logs","DATA") then
		file.CreateDir('dlogs_logs')
	end

	for k,v in pairs(dLogs.max) do
		if !file.Exists("dlogs_logs/"..string.lower(k),"DATA") then
			file.CreateDir('dlogs_logs/'..string.lower(k))
		end
	end
end

SetupFilePaths()
