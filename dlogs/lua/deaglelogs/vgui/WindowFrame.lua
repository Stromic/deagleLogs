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

	self:SetSize(700,300)
	self:SetPos(ScrW()*.5-450,ScrH()*.2-300)
	self:SetDraggable( true )
	self:SetSizable(false)
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
	self.Title:SetText( "Windowed Logs" )
	self.Title:SetColor( Color(0,0,0) )
	self.Title:SetFont( "dLogs_PenguinTheme.Title" )

end

function PANEL:PerformLayout()

	self.CloseB:SetPos( self:GetWide() - 31, 1 )
	self.CloseB:SetSize( 30, 25 )

	self.Title:SizeToContents()
	self.Title:SetPos( self:GetWide()/2 - self.Title:GetWide()/2, 4 )
	self.Title:SetSize( self.Title:GetWide(), 20 )

end

function PANEL:Close()
		self:Remove()
end

function PANEL:Paint()

	local w, h = self:GetWide(), self:GetTall()

	DrawOutlinedBox( w, h, Color(255,255,255),Color(0,0,0) )
end

vgui.Register( "dLogs_Window", PANEL, "DFrame" )
