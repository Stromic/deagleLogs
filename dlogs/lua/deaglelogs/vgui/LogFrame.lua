/******************************************************************************
*                            dLogs - Derma Frame                              *
*                          Theme by aStonedPenguin                            *
*              http://steamcommunity.com/profiles/76561198074794075/          *
******************************************************************************/

local PANEL = {}

function PANEL:Init()

	self.btnClose:Remove()
	self.btnMaxim:Remove()
	self.btnMinim:Remove()
	self.lblTitle:Remove()

	self:SetSize( 900, 500 )
	self:SetPos( 0 - self:GetWide(), ScrH()/2 - self:GetTall()/2 )
	self:MoveTo( ScrW()/2 - self:GetWide()/2, ScrH()/2 - self:GetTall()/2, 0.12, 0, 1 )
	self:MakePopup()
	self:SetDraggable( false )
	self:SetSkin( dLogs.DermaTheme )

	self.CloseB = vgui.Create( "DButton", self )
	self.CloseB:SetText( "" )
	self.CloseB.DoClick = function()
		self:Close()
		surface.PlaySound( "UI/buttonclick.wav" )
	end
	self.CloseB.Paint = function( panel, w, h )
		derma.SkinHook( "Paint", "WindowCloseButton", panel, w, h )
	end

	self.Title = vgui.Create( "DLabel", self )
	self.Title:SetText( "The Logs" )
	self.Title:SetColor( Color(0,0,0) )
	self.Title:SetFont( "dLogs_PenguinTheme.Title" )

	self.TabList = vgui.Create("DPanelList", self )
	self.TabList:EnableVerticalScrollbar( true )


end

function PANEL:PerformLayout()

	self.CloseB:SetPos( self:GetWide() - 31, 1 )
	self.CloseB:SetSize( 30, 25 )

	self.Title:SizeToContents()
	self.Title:SetPos( self:GetWide()/2 - self.Title:GetWide()/2, 4 )
	self.Title:SetSize( self.Title:GetWide(), 20 )

	self.TabList:SetSize( 130, self:GetTall() - 40 )
	self.TabList:SetPos( 5, 30 )
	self.TabList:SetSpacing( -2 )

end

function PANEL:Close()

	self:MoveTo( ScrW() - self:GetWide(), ScrH()/2 - self:GetTall()/2, 0.12, 0, 1 )

	timer.Create( "RemoveWindow", .12, 1, function ()
		self:Remove()
	end)

end

function PANEL:AddTabs() // If we add this to the Init it trys to add tabs before PerformLayout()
	for k,v in pairs( dLogs.Menus ) do
		self.TabButton = vgui.Create("DButton", self.TabList )
		self.TabButton:SetText( v.Name )
		self.TabButton:SetSize(100,31)
		self.TabButton.DoClick = function()
			RunConsoleCommand("dlogs",v.RawName)
		end
		self.TabButton.DoRightClick = function(us)

			local menu = DermaMenu()
			menu:AddOption("Open in New Window",function()

				for k,v in pairs(dLogs.Menus) do

					if us:GetValue() == v.Name then
						local Window = vgui.Create("dLogs_Window")
						Window.TitleText = v.Name.." Windowed"
						Window:SetDraggable( true )
						Window:SetSkin( dLogs.DermaTheme )

						v.MakePanel(Window)
						v.Panel.Windowed = true
					end
				end
			end)
			menu:Open()
		end
		self.TabList:AddItem( self.TabButton )
	end
end

function PANEL:Paint()

	local w, h = self:GetWide(), self:GetTall()

	DrawOutlinedBox( w, h, Color(255,255,255),Color(0,0,0) )
	local tab = dLogs.GetCurrentTab()
	if tab == nil or tab == "" then


		--draw.RoundedBox( 0, dLogs.pos.x+150,dLogs.pos.y+30, 170, 31, Color(51,153,255))

		draw.RoundedBox( 0, dLogs.pos.x+150,dLogs.pos.y+30, 170, 31, Color(51,153,255))


		local struc = {}
		struc["pos"] = {dLogs.pos.x+150+80, dLogs.pos.y+30+15}
		struc["color"] = Color(255, 255, 255, 255)
		struc["text"] = "< Select a Category"

		struc["font"] = "dLogs_PenguinTheme.Button"
		struc["xalign"] = TEXT_ALIGN_CENTER
		struc["yalign"] = TEXT_ALIGN_CENTER
		draw.TextShadow( struc, 1, 50)
	end
end

vgui.Register( "LogFrame", PANEL, "DFrame" )
