--makeheading
local chat = chat
local util =  util
local string = string
local pairs = pairs
local table = table

local CATEGORY = {}
CATEGORY.Name = "Name Changes"
CATEGORY.RawName = "Name"
CATEGORY.Order = 1
CATEGORY.Data = {}
--CATEGORY.Disabled = 1
CATEGORY.Pages =1;
CATEGORY.MaxPages=1;
CATEGORY.Query = "time varchar(255), steam_id varchar(255), steam_name varchar(255), oldname varchar(255), newname varchar(255), ip_address varchar(255)"
CATEGORY.SearchVars = {
["Steam ID"] = {val="steam_id",ex="[Example] STEAM_0:1:32634764",default=true},
["Steam Name"] = {val="steam_name",ex="[Example] Deagler"},
["Old Name"] = {val="oldname",ex="[Example] Neo Bowden"},
["New Name"] = {val="newname",ex="[Example] Nero Silverwing"},
["IP Address"] = {val="ip_address",ex="[Example] 192.1.1.254"}
}
CATEGORY.InvolvedPlayers = {}


function CATEGORY.GetData(page)
net.Start(dLogs.prefix.."_getData")
	net.WriteString(CATEGORY.RawName)
	net.WriteInt(dLogs.max[CATEGORY.RawName],32)
	net.WriteInt(page,32)
net.SendToServer()
end

local function copied(str)
	chat.AddText(Color(255,255,255),"["..dLogs.prefix.."] ",Color(255,128,0),str)
end

function CATEGORY.OpenRightClick(line,data)
	local RightClick = DermaMenu()

	RightClick:AddOption("Copy Line",function()
		SetClipboardText(line:GetValue(1).." "..line:GetValue(2))
		copied([["]]..line:GetValue(1).." "..line:GetValue(2)..[[" copied to clipboard.]])
		RightClick:Hide()
	end)

	local namer = RightClick:AddSubMenu(data.name)

	namer:AddOption("Steam Name: "..data.steam_name,function()
		SetClipboardText(data.steam_name)
		copied("\""..data.steam_name.."\" copied to clipboard.")
		RightClick:Hide()
	end)

	namer:AddOption("SteamID: "..data.steam_id,function()
		SetClipboardText(data.steam_id)
		copied("\""..data.steam_id.."\" copied to clipboard.")
		RightClick:Hide()
	end)

	if dLogs.canView(LocalPlayer(),"IP") then
		namer:AddOption("IP Address: "..data.ip_address,function()
			SetClipboardText(data.ip_address)
			copied("\""..data.ip_address.."\" copied to clipboard.")
			RightClick:Hide()
		end)
	end

	RightClick:Open()
end

local function TryFillUpBox()

		timer.Simple(0.02,function()
			if IsValid(CATEGORY.ListView) then
				if CATEGORY.ListView.VBar.Enabled then CATEGORY.ListView.VBar:SetScroll(CATEGORY.ListView.VBar.CanvasSize) end


				table.Empty(CATEGORY.InvolvedPlayers)
				CATEGORY.AddOptions()
				CATEGORY.HighlightData(LocalPlayer():Name())
			end
		end)
end

local function UpdatePages() -- retard codes lua lmao im so bad.
	if CATEGORY.Page==1 then
		CATEGORY.PageF:SetVisible(false)
		CATEGORY.PageB:SetVisible(false)
	else
		CATEGORY.PageF:SetVisible(true)
		CATEGORY.PageB:SetVisible(true)
	end

	if CATEGORY.Page==CATEGORY.MaxPages then
		CATEGORY.PageL:SetVisible(false)
		CATEGORY.PageN:SetVisible(false)
	else
		CATEGORY.PageL:SetVisible(true)
		CATEGORY.PageN:SetVisible(true)
	end

	CATEGORY.PageLabel:SetText(Format("%s/%s",CATEGORY.Page,CATEGORY.MaxPages))
	CATEGORY.PageLabel:SizeToContents()
end

function CATEGORY.FillData()
	local logType = net.ReadString()
	if logType != CATEGORY.RawName then return end
	local lol = net.ReadString()
	CATEGORY.Page = net.ReadInt(32)
	CATEGORY.MaxPages = net.ReadInt(32)
	CATEGORY.Data = lol and util.JSONToTable(lol) or CATEGORY.Data
	if !CATEGORY.ListView then return end
	CATEGORY.ListView:Clear()
	for k,v in pairs(CATEGORY.Data) do
		local log = Format([[%s(%s) changed their name from "%s" to "%s"]],v.steam_name,v.role,v.oldname,v.newname)
		local line = CATEGORY.ListView:AddLine(os.date("%x %I:%M:%S %p",v.time) , log , util.TableToJSON(v) , v.time )
		line:SetToolTip(log)
		CATEGORY.ListView:SortByColumn(4,false)
	end

	TryFillUpBox()

	UpdatePages()
end
net.Receive(dLogs.prefix.."_send"..string.lower(CATEGORY.RawName).."Data",CATEGORY.FillData)


function CATEGORY.HighlightData(Name)
	CATEGORY.ListView:ClearSelection()
	local lines = CATEGORY.ListView:GetLines()

	for k,v in pairs(lines) do
		local tab = util.JSONToTable(v:GetColumnText(3))
		if tab.steam_name == Name then
			CATEGORY.ListView:SelectItem(v)
		end
	end

end

function CATEGORY.AddOptions()
if !IsValid(CATEGORY.minimalSearch) then return end
	CATEGORY.minimalSearch:Clear()
	for k,v in pairs(CATEGORY.Data) do
		if v.steam_name then
			CATEGORY.InvolvedPlayers[v.steam_name] = true
		end
	end
	local sortedtab = {}

	for k,v in pairs(CATEGORY.InvolvedPlayers) do
		if k then
			table.insert(sortedtab,k)
		end
	end
	table.sort(sortedtab,function(a,b) return a>b end)

	if CATEGORY.minimalSearch then
		for k,v in pairs(sortedtab) do
			if v then
				CATEGORY.minimalSearch:AddChoice(v)
				if v == LocalPlayer():SteamName() then
					CATEGORY.minimalSearch:ChooseOption(v)
				end
			end
		end
	end

	if !CATEGORY.minimalSearch:GetOptionText() then
		CATEGORY.minimalSearch:SetValue("Choose a Player")
	end
end


function CATEGORY.MakeColumns()
   --Actual Columns
	local time = CATEGORY.ListView:AddColumn("Time")
	time:SetFixedWidth(130)
	time.Header:SetDisabled(true)

	local log  = CATEGORY.ListView:AddColumn("Log")
	log:SetFixedWidth(CATEGORY.ListView:GetWide()-130)
	log.Header:SetDisabled(true)
	--Actual Columns

	--Extra Columns
	local search = CATEGORY.ListView:AddColumn("")
	search:SetFixedWidth(0)
	search.Header:SetDisabled(true)

	local realtime = CATEGORY.ListView:AddColumn("")
	realtime:SetFixedWidth(0)
	realtime.Header:SetDisabled(true)
	--Extra Columns
end

function CATEGORY:Search(HowUnique)
	local searchValue = HowUnique.value
	local searchType = HowUnique.type
	local searchAmount = HowUnique.amount
	if !searchType then print("ERROR VAR DLOGS",searchType,searchValue,searchAmount) return end

	searchAmount = tonumber(searchAmount)

	if !searchAmount then print("ERROR AMOUNT DLOGS",searchType,searchValue,searchAmount) return end

	net.Start(dLogs.prefix.."_getSearchData")
		net.WriteString(CATEGORY.RawName)
		net.WriteInt(searchAmount,32)
		net.WriteString(searchType)
		net.WriteString(searchValue)
	net.SendToServer()
end

function CATEGORY.MakeSearchBox()
	local x,y = CATEGORY.frame:GetPos()
	local selected
	CATEGORY.SearchPanel = vgui.Create("DFrame")
	CATEGORY.SearchPanel:SetSize(350,100)
	CATEGORY.SearchPanel:SetSizable(false)
	CATEGORY.SearchPanel:SetPos(x+250,y+230)
	CATEGORY.SearchPanel:SetTitle(CATEGORY.Name.." Extensive Search")
	CATEGORY.SearchPanel.btnMinim:SetVisible(false)
	CATEGORY.SearchPanel.btnMaxim:SetVisible(false)
	CATEGORY.SearchPanel:MoveTo(x+250, y+250+183 , 0.2 )
	CATEGORY.SearchPanel:MakePopup()
	CATEGORY.SearchPanel:SetSkin("dLogsPenguinTheme")

	local searchLabel = vgui.Create("DLabel", CATEGORY.SearchPanel)
	searchLabel:SetText("Search by:")
	searchLabel:SetFont("DefaultBold")
	searchLabel:SetTextColor(Color(255,255,255))
	searchLabel:SizeToContents()
	searchLabel:SetPos(5,CATEGORY.SearchPanel:GetTall()*.2+5)

	local searchBy = vgui.Create("DComboBox",CATEGORY.SearchPanel)
	searchBy:SetSize(CATEGORY.SearchPanel:GetWide()/3 , 20 )
	searchBy:SetPos(5,CATEGORY.SearchPanel:GetTall()*.3+8)
	for k,v in pairs(CATEGORY.SearchVars) do
		if v and k then
			searchBy:AddChoice(k)

			if v.default then
				searchBy:ChooseOption(k)
				selected=k
			end
		end
	end


	local amountLabel = vgui.Create("DLabel", CATEGORY.SearchPanel)
	amountLabel:SetText("Amount to display:")
	amountLabel:SetFont("DefaultBold")
	amountLabel:SetTextColor(Color(255,255,255))
	amountLabel:SizeToContents()
	amountLabel:SetPos(searchLabel:GetWide()+100,CATEGORY.SearchPanel:GetTall()*.2+5)

	local amountText = vgui.Create("DTextEntry", CATEGORY.SearchPanel)
	amountText:SetMultiline(false)
	amountText:SetNumeric()
	amountText:SetSize(amountLabel:GetWide()+50,20)
	amountText:SetPos(searchLabel:GetWide()+100,CATEGORY.SearchPanel:GetTall()*.3+8)
	amountText:SetValue("300")

	local valueLabel = vgui.Create("DLabel", CATEGORY.SearchPanel)
	valueLabel:SetText("Search Value:")
	valueLabel:SetFont("DefaultBold")
	valueLabel:SetTextColor(Color(255,255,255))
	valueLabel:SizeToContents()
	valueLabel:SetPos(5,CATEGORY.SearchPanel:GetTall()*.565)

	local valueText = vgui.Create("DTextEntry", CATEGORY.SearchPanel)
	valueText:SetMultiline(false)
	valueText:SetSize(valueLabel:GetWide()+220,20)
	valueText:SetPos(5,CATEGORY.SearchPanel:GetTall()*.7)
	valueText:SetTextColor(Color(105,105,105))
	valueText:SetValue(CATEGORY.SearchVars[selected].ex)
	valueText.OnEnter = function()
		local unique = {
		["value"] = valueText:GetValue(),
		["type"] = CATEGORY.SearchVars[selected].val,
		["amount"] = amountText:GetValue()
		}
		CATEGORY:Search(unique)
	end

	valueText.OnMousePressed = function()

		if string.sub(valueText:GetValue(),1,9) == "[Example]" then
			valueText:SetValue("")
			valueText:SetTextColor(Color(0,0,0))
		end
	end

	searchBy.OnSelect = function(p,i,val,dat)
		selected=val
		valueText:SetValue(CATEGORY.SearchVars[selected].ex)
		valueText:SetTextColor(Color(105,105,105))
	end

	local searchButton = vgui.Create("DButton",CATEGORY.SearchPanel)
	searchButton:SetSize(40,CATEGORY.SearchPanel:GetTall()-44)
	searchButton:SetPos(CATEGORY.SearchPanel:GetWide()-50,34)
	searchButton:SetText("-->")
	searchButton.DoClick = function()
		local unique = {
		["value"] = valueText:GetValue(),
		["type"] = CATEGORY.SearchVars[selected].val,
		["amount"] = amountText:GetValue()
		}
		CATEGORY:Search(unique)
	end

end




local function SaveLogs() -- the worst most stupid and messiest way to do this.
	local currenttime = os.date("[%d.%m.%Y] %I.%M.%S %p",os.time())
	local ourfile = "dlogs_logs/"..string.lower(CATEGORY.RawName).."/"..currenttime..".txt"
	local stringtowrite = "deagleLogs - Clientside "..CATEGORY.RawName.." Logs\n"..os.date("%x %I:%M:%S %p",os.time()).."\n======================================\n"
	stringtowrite =  stringtowrite.."\nInvolved Players:\n"

	local sortedtab = {}
	for k,v in pairs(CATEGORY.InvolvedPlayers) do
		if k then
			table.insert(sortedtab,k)
		end
	end
	table.sort(sortedtab,function(a,b) return a>b end)

	for k,v in pairs(sortedtab) do
		stringtowrite = stringtowrite.."\t"..v.."\n"
	end
	local data = CATEGORY.Data

	table.sort(data,function(a,b) return a.time <  b.time end)
	stringtowrite = stringtowrite.."\n======================================\nLogs Begin\n\n"
	for k,v in pairs(data) do
		if v then
			local format = dLogs.GetFullLog(CATEGORY.RawName,v)
			format = os.date("%I:%M:%S %p",v.time).."\t\t"..format
			stringtowrite=stringtowrite..format.."\n"
		end
	end

	stringtowrite=stringtowrite.."\nLogs End\n======================================"

	file.Write(ourfile,stringtowrite)

	copied("Logs saved to ".."data/"..ourfile)
end

function CATEGORY.MakeExtra()

	CATEGORY.minimalSearch = vgui.Create("DComboBox", CATEGORY.Panel)
	CATEGORY.minimalSearch:SetPos( 10, CATEGORY.Panel:GetTall() - 25 )
	CATEGORY.minimalSearch:SetSize( CATEGORY.Panel:GetWide()/3 , 20 )
	CATEGORY.minimalSearch.OnSelect = function(panel,index)
		CATEGORY.HighlightData(CATEGORY.minimalSearch:GetOptionText(index))
	end

--[[ 	local extensiveSearch = vgui.Create("DButton", CATEGORY.Panel)
	extensiveSearch:SetPos(CATEGORY.minimalSearch:GetWide()+10, CATEGORY.Panel:GetTall()*.945)
	extensiveSearch:SetSize(150,20)
	extensiveSearch:SetText("Extensive Search")
	extensiveSearch.DoClick = function()
		CATEGORY.MakeSearchBox()
	end ]]

	local clearReset = vgui.Create("DButton", CATEGORY.Panel)
	clearReset:SetPos( CATEGORY.Panel:GetWide() - 70, CATEGORY.Panel:GetTall()- 25 )
	clearReset:SetSize( 65, 20 )
	clearReset:SetText( "Clear" )
	clearReset.DoClick = function()
		CATEGORY.ListView:Clear()
		CATEGORY.minimalSearch:Clear()
		CATEGORY.GetData(CATEGORY.Page)
		surface.PlaySound("ui/buttonclick.wav")
	end

	local saveLogs = vgui.Create("DButton", CATEGORY.Panel)
	saveLogs:SetPos( CATEGORY.Panel:GetWide() - 200, CATEGORY.Panel:GetTall()- 25 )
	saveLogs:SetSize( 120, 20 )
	saveLogs:SetText( "Save as .txt" )
	saveLogs.DoClick = function()
		SaveLogs()
		surface.PlaySound("ui/buttonclick.wav")
	end

end

local function MakeBasePageSystem()

	CATEGORY.PageLabel = vgui.Create("DLabel",CATEGORY.Panel)
	CATEGORY.PageLabel:SetTextColor(Color(0,0,0))
	CATEGORY.PageLabel:SetFont("dLogs_PenguinTheme.Button")
	CATEGORY.PageLabel:SetText(Format("%s/%s",CATEGORY.Page,CATEGORY.MaxPages))
	CATEGORY.PageLabel:SizeToContents()
	CATEGORY.PageLabel:SetPos(CATEGORY.Panel:GetWide()-375,CATEGORY.Panel:GetTall()-25)

	CATEGORY.PageF = vgui.Create("DButton",CATEGORY.Panel)
	CATEGORY.PageF:SetText("<<<")
	CATEGORY.PageF:SetSize( 30, 20 )
	CATEGORY.PageF:SetPos( CATEGORY.Panel:GetWide() - 450, CATEGORY.Panel:GetTall()- 25 )
	CATEGORY.PageF.DoClick = function()
		CATEGORY.Page=1;
		CATEGORY.GetData(1)
		surface.PlaySound("ui/buttonclick.wav")
	end


	CATEGORY.PageB = vgui.Create("DButton",CATEGORY.Panel)
	CATEGORY.PageB:SetText("<")
	CATEGORY.PageB:SetSize( 30, 20 )
	CATEGORY.PageB:SetPos( CATEGORY.Panel:GetWide() - 415, CATEGORY.Panel:GetTall()- 25 )
	CATEGORY.PageB.DoClick = function()
		CATEGORY.Page=CATEGORY.Page-1;
		CATEGORY.GetData(CATEGORY.Page)
		surface.PlaySound("ui/buttonclick.wav")
	end

	CATEGORY.PageN = vgui.Create("DButton",CATEGORY.Panel)
	CATEGORY.PageN :SetText(">")
	CATEGORY.PageN :SetSize( 30, 20 )
	CATEGORY.PageN :SetPos( CATEGORY.Panel:GetWide() - 335, CATEGORY.Panel:GetTall()- 25 )
	CATEGORY.PageN .DoClick = function()
		CATEGORY.Page=CATEGORY.Page+1;
		CATEGORY.GetData(CATEGORY.Page)
		surface.PlaySound("ui/buttonclick.wav")
	end


	CATEGORY.PageL = vgui.Create("DButton",CATEGORY.Panel)
	CATEGORY.PageL:SetText(">>>")
	CATEGORY.PageL:SetSize( 30, 20 )
	CATEGORY.PageL:SetPos( CATEGORY.Panel:GetWide() - 300, CATEGORY.Panel:GetTall()- 25 )
	CATEGORY.PageL.DoClick = function()
		CATEGORY.Page=CATEGORY.MaxPages;
		CATEGORY.GetData(CATEGORY.MaxPages)
		surface.PlaySound("ui/buttonclick.wav")
	end

	UpdatePages()

end

function CATEGORY.MakePanel(window)

	local parent
	if window then parent = window else parent = dLogs.dFrame end
	CATEGORY.Panel = vgui.Create("LogPanel" ,parent )

	CATEGORY.ListView = vgui.Create("DListView",CATEGORY.Panel)
	CATEGORY.ListView:SetSize( CATEGORY.Panel:GetWide() - 10,CATEGORY.Panel:GetTall() - 35 )
	CATEGORY.ListView:SetPos( 5, 5 )
	CATEGORY.ListView:SetMultiSelect(true)
	CATEGORY.ListView.OnClickLine = function() return end
	CATEGORY.ListView.OnRowRightClick = function(parent,line)
		CATEGORY.OpenRightClick(CATEGORY.ListView:GetLine(line),util.JSONToTable(CATEGORY.ListView:GetLine(line):GetColumnText(3)))
	end


	MakeBasePageSystem()
	CATEGORY.MakeColumns()
	CATEGORY.MakeExtra()
	CATEGORY.Page = 1;
	CATEGORY.GetData(1)
end
dLogs.AddMenu(CATEGORY)
