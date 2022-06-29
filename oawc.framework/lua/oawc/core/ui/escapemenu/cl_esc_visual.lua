for i=1, 100 do
    surface.CreateFont( "oawc.esc."..i, {
        font = "Bauhaus Bold BT", 
        size = i,
        weight = 700,
    } )

    surface.CreateFont( "oawc.escT."..i, {
        font = "Bauhaus Bold BT", 
        size = i,
        weight = 600,
    } )
end

local logo = Material("materials/escapemenu/logo.png")


local function openESC()
    escPNL = vgui.Create("DPanel")
    escPNL:SetSize(ScrW(), ScrH())
    escPNL:Center()
    escPNL:MakePopup()
    escPNL.Paint = function(s, w, h)
        surface.SetDrawColor(30, 30, 30, 150)
        surface.DrawRect(0, 0, w, h)
        DrawBlurRect(0, 0, w, h, 3, 6)
        draw.SimpleText("One Alone Wolf Community", "oawc.esc.55", w * .17, h * .12, Color(230, 230, 230), TEXT_ALIGN_LEFT, 1)
        draw.SimpleText("SCP:RP", "oawc.esc.35", w * .17 + 5, h * .17, Color(183, 131, 0), TEXT_ALIGN_LEFT, 1)

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(logo, "smooth")
        surface.DrawTexturedRect(w * .06, h * 0 + 50, 200,200)
    end

    

    local discord = vgui.Create("DButton", escPNL)
    discord:SetSize(ScrW() * .15, 75)
    discord:SetPos(ScrW() * .1, ScrH() * .3 - 35)
    discord:SetText("")
    discord.Paint = function(s, w, h)


        if s:IsHovered() then 
            draw.SimpleText("OAWC Discord", "oawc.escT.41", 0, h / 2, Color(255, 183, 0), TEXT_ALIGN_LEFT, 1)
        else
            draw.SimpleText("OAWC Discord", "oawc.escT.40", 0, h / 2, Color(250,250,250), TEXT_ALIGN_LEFT, 1)
        end
    end
    discord.DoClick = function()
        escPNL:Remove()
        surface.PlaySound("Resource/warning.wav")
        gui.OpenURL(OAWC.Config_ui_discord)
    end

    local steam = vgui.Create("DButton", escPNL)
    steam:SetSize(ScrW() * .15, 75)
    steam:SetPos(ScrW() * .1, ScrH() * .38 - 35)
    steam:SetText("")
    steam.Paint = function(s, w, h)


        if s:IsHovered() then 
            draw.SimpleText("Server Kollektion", "oawc.escT.41", 0, h / 2, Color(255, 183, 0), TEXT_ALIGN_LEFT, 1)
        else
            draw.SimpleText("Server Kollektion", "oawc.escT.40", 0, h / 2, Color(250,250,250), TEXT_ALIGN_LEFT, 1)
        end
    end
    steam.DoClick = function()
        escPNL:Remove()
        surface.PlaySound("Resource/warning.wav")
        gui.OpenURL(OAWC.Config_ui_kollektion)
    end

    local Optionen = vgui.Create("DButton", escPNL)
    Optionen:SetSize(ScrW() * .15, 75)
    Optionen:SetPos(ScrW() * .1, ScrH() * .46 - 35)
    Optionen:SetText("")
    Optionen.Paint = function(s, w, h)


        if s:IsHovered() then 
            draw.SimpleText("Einstellungen", "oawc.escT.41", 0, h / 2, Color(255, 183, 0), TEXT_ALIGN_LEFT, 1)
        else
            draw.SimpleText("Einstellungen", "oawc.escT.40", 0, h / 2, Color(250,250,250), TEXT_ALIGN_LEFT, 1)
        end
    end
    Optionen.DoClick = function()
        escPNL:Remove()
        surface.PlaySound("Resource/warning.wav")
        gui.ActivateGameUI()
    end

    
    local weiter = vgui.Create("DButton", escPNL)
    weiter:SetSize(ScrW() * .15, 75)
    weiter:SetPos(ScrW() * .1, ScrH() * .6 - 35)
    weiter:SetText("")
    weiter.Paint = function(s, w, h)

        if s:IsHovered() then 
            draw.SimpleText("Weiter Spielen", "oawc.escT.41", 0, h / 2, Color(255, 183, 0), TEXT_ALIGN_LEFT, 1)
        else
            draw.SimpleText("Weiter Spielen", "oawc.escT.40", 0, h / 2, Color(250,250,250), TEXT_ALIGN_LEFT, 1)
        end
    end

    weiter.DoClick = function()
        surface.PlaySound("Resource/warning.wav")
        escPNL:Remove()
    end

    local disc = vgui.Create("DButton", escPNL)
    disc:SetSize(ScrW() * .15, 75)
    disc:SetPos(ScrW() * .1, ScrH() * .68 - 35)
    disc:SetText("")
    disc.Paint = function(s, w, h)


        if s:IsHovered() then 
            draw.SimpleText("Disconnecten", "oawc.escT.41", 0, h / 2, Color(255, 183, 0), TEXT_ALIGN_LEFT, 1)
        else
            draw.SimpleText("Disconnecten", "oawc.escT.40", 0, h / 2, Color(250,250,250), TEXT_ALIGN_LEFT, 1)
        end
    end

    disc.DoClick = function()
        surface.PlaySound("Resource/warning.wav")
        local msg = vgui.Create("DPanel", escPNL)
        msg:SetSize(400,70)
        msg:Center()
        msg.Paint = function(s, w, h)
            surface.SetDrawColor(30, 30, 30, 150)
            surface.DrawRect(0, 0, w, h)
            DrawBlurRect(0, 0, w, h, 3, 6)
            draw.SimpleText("Auf wiedersehen! "..LocalPlayer():Nick(), "oawc.escT.20", w / 2, h / 2 - 15, Color(250,250,250), 1, 1)
            draw.SimpleText("~OAWC", "oawc.escT.15", w / 2, h / 2 + 15, Color(255,30,30), 1, 1)


        end 

        timer.Simple(1, function()
            LocalPlayer():ConCommand("disconnect")
        end)
    end 

end

hook.Add('PreRender', 'esc-menu', function()
	if input.IsKeyDown(KEY_ESCAPE) and gui.IsGameUIVisible() then
		if ValidPanel(escPNL) then
			gui.HideGameUI()
			escPNL:Remove()
		else
			gui.HideGameUI()
			openESC()
		end
	end
end)
