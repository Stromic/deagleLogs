/******************************************************************************
*                            dLogs - Derma Theme                              *
*                          Theme by aStonedPenguin                            *
*              http://steamcommunity.com/profiles/76561198074794075/          *
******************************************************************************/

function DrawOutlinedBox( w, h, col1, col2 )
	draw.RoundedBox( 0, 1, 1, w - 2, h - 2, col1 )
	surface.SetDrawColor( col2 )
	surface.DrawOutlinedRect( 0, 0, w, h )
end

dLogs_PenguinTheme = {}

dLogs_PenguinTheme.PrintName          = "PenguinsTheme"

dLogs_PenguinTheme.Author             = "aStonedPenguin"

dLogs_PenguinTheme.DermaVersion       = 1

dLogs_PenguinTheme.FrameBackgorund = Color(224, 224, 224)

dLogs_PenguinTheme.Highlight = Color(200,200,200)

dLogs_PenguinTheme.Text = Color(0,0,0)

dLogs_PenguinTheme.Outline = Color(150, 150, 150)


----------------------------------------------------------------
-- Close Button                                               --
----------------------------------------------------------------
function dLogs_PenguinTheme:PaintWindowCloseButton(panel, w, h)

	if (!panel.m_bBackground) then return end
	local Background = Color(255,255,255)
	local CloseX = dLogs_PenguinTheme.Text

	if( panel.Depressed || panel:IsSelected() || panel.Hovered ) then
		Background = Color(255, 51, 51, 255)
		CloseX = Color(255, 255, 255, 255)
	end

	draw.RoundedBox(0, 0, 0, w, h, Background)
	draw.SimpleText("X", "dLogs_PenguinTheme.Close", w/2+1, h/2+1, CloseX, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

end
dLogs.pos = {}
dLogs.pos.x = 0
dLogs.pos.y = 0
----------------------------------------------------------------
-- Buttons                                                    --
----------------------------------------------------------------
local DoOutline = { "Clear", "Time","Log", "Save as .txt", "<<<", "<", ">" , ">>>" }
function dLogs_PenguinTheme:PaintButton(panel, w, h)

	if (!panel.m_bBackground) then return end

	panel:SetTextColor( Color(0,0,0) )
	panel:SetFont( "dLogs_PenguinTheme.Button" )

	local Highlight = Color(255,255,255)


	if panel.Depressed or panel.Hovered and dLogs.GetCurrentTab() != panel:GetText() and panel:GetDisabled() == false then
		local x,y = panel:GetPos()
		dLogs.pos.x,dLogs.pos.y=x,y
		Highlight = Color(192,192,192)
	end

	if dLogs.GetCurrentTab() == panel:GetText() then
		Highlight = Color(51,153,255)
		panel:SetTextColor( Color(255,255,255) )
	end

	if table.HasValue( DoOutline, panel:GetText() ) then
		DrawOutlinedBox( w, h, Highlight, dLogs_PenguinTheme.Outline )
	else
		draw.RoundedBox( 0, 1, 1, w - 2, h - 2, Highlight )
	end



	panel:SetTextColor( Color(0,0,0) )
	panel:SetFont( "dLogs_PenguinTheme.Button" )

	local Highlight = Color(255,255,255)


	if panel.Depressed or panel.Hovered and dLogs.GetCurrentTab() != panel:GetText() and panel:GetDisabled() == false then
		local x,y = panel:GetPos()
		dLogs.pos.x,dLogs.pos.y=x,y
		Highlight = Color(192,192,192)
	end


	if dLogs.GetCurrentTab() == panel:GetText() then
		Highlight = Color(51,153,255)
		panel:SetTextColor( Color(255,255,255) )
	end

	draw.RoundedBox( 0, 1, 1, w - 2, h - 2, Highlight )


end

----------------------------------------------------------------
-- ComboBox                                                   --
----------------------------------------------------------------
function SKIN:PaintComboBox( panel, w, h )

	if ( panel.Depressed || panel:IsMenuOpen() ) then
		panel:SetTextColor(Color(255,255,255))
		return DrawOutlinedBox( w, h, Color(51,153,255), dLogs_PenguinTheme.Outline )

	end

	if ( panel.Hovered ) then
		return DrawOutlinedBox( w, h, Color(192,192,192), dLogs_PenguinTheme.Outline )
	end

	DrawOutlinedBox( w, h, Color(255,255,255), dLogs_PenguinTheme.Outline )

end

----------------------------------------------------------------
-- ListView                                                   --
----------------------------------------------------------------
function SKIN:PaintListViewLine( panel, w, h )

	if ( panel:IsSelected() ) then

		draw.RoundedBox( 0, 0, 0, w, h, dLogs.CommunityCol )

	elseif ( panel.Hovered ) then

		draw.RoundedBox( 0, 0, 0, w, h, Color(192,192,192))

	elseif ( panel.m_bAlt ) then

		draw.RoundedBox( 0, 0, 0, w, h, dLogs_PenguinTheme.Highlight )

	end

end




function SKIN:PaintListView( panel, w, h )

	DrawOutlinedBox( w, h, Color(235,235,235), dLogs_PenguinTheme.Outline )

end


----------------------------------------------------------------
-- Scrollbar                                                  --
----------------------------------------------------------------
function dLogs_PenguinTheme:PaintVScrollBar( panel, w, h ) end

function dLogs_PenguinTheme:PaintScrollBarGrip( panel, w, h )

	local Background = dLogs_PenguinTheme.Highlight

	if panel:GetParent().btnGrip.Depressed then
		Background = dLogs.CommunityCol
	end

	DrawOutlinedBox( w, h, Background, dLogs_PenguinTheme.Outline )

end

function dLogs_PenguinTheme:PaintButtonUp( panel, w, h )

	if ( !panel.m_bBackground ) then return end
	panel:SetTextColor(Color(0,0,0))
	local Background = Color(255,255,255)

	if panel:GetParent().btnUp.Depressed and dLogs.GetCurrentTab() != panel:GetText() and panel:GetDisabled() == false  then
		Background = Color(192,192,192)
	end



	if dLogs.GetCurrentTab() == panel:GetText() then
		Background = Color(51,153,255)
		panel:SetTextColor( Color(255,255,255) )
	end
	draw.RoundedBox( 0, 1, 1, w - 2, h - 2, Background )

end

function dLogs_PenguinTheme:PaintButtonDown( panel, w, h )

	if ( !panel.m_bBackground ) then return end
	panel:SetTextColor(Color(0,0,0))
	local Background = Color(255,255,255)

	if panel:GetParent().btnUp.Depressed and dLogs.GetCurrentTab() != panel:GetText() and panel:GetDisabled() == false then
		Background = Color(192,192,192)
	end


	if dLogs.GetCurrentTab() == panel:GetText() then
		Background = Color(51,153,255)
		panel:SetTextColor( Color(255,255,255) )
	end
	draw.RoundedBox( 0, 1, 1, w - 2, h - 2, Background )

end

derma.DefineSkin( "dLogs_PenguinTheme", "The official dLogs theme", dLogs_PenguinTheme )
