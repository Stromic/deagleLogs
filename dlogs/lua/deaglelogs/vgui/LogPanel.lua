/******************************************************************************
*                            dLogs - Derma Panel                              *
*                          Theme by aStonedPenguin                            *
*              http://steamcommunity.com/profiles/76561198074794075/          *
******************************************************************************/

local PANEL = {}

function PANEL:Init()
	local x,y = 140,30
	local w = self:GetParent():GetWide() - 150
	if self:GetParent() != dLogs.dFrame then
		x,y=2,30
		w=self:GetParent():GetWide() - 4
	end
	self:SetPos( x, y )
	self:SetSize( w, self:GetParent():GetTall() - 40 )

end

function PANEL:Paint()

	local w, h = self:GetWide(), self:GetTall()

	DrawOutlinedBox( w, h, dLogs_PenguinTheme.FrameBackgorund, dLogs_PenguinTheme.Outline )

end

vgui.Register( "LogPanel", PANEL )
