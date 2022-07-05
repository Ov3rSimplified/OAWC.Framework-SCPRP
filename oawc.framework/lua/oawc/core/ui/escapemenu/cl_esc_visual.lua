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

    local ppbg = vgui.Create("DPanel", escPNL)
    ppbg:SetSize(500, 300)
    ppbg:SetPos(escPNL:GetWide() - 600, escPNL:GetTall() * 0.5 - 150)
    ppbg.Paint = function(s, w, h)
        surface.SetDrawColor(0, 0, 0, 200)
        surface.DrawOutlinedRect(0, 0, w, h)
        surface.SetDrawColor(0, 0, 0, 100)
        surface.DrawRect(0, 0, w, h)
    end 

    local scroll = vgui.Create("DScrollPanel", ppbg)
    scroll:SetPos(0, ppbg:GetTall() * 0.03)
    scroll:SetSize(ppbg:GetWide(), ppbg:GetTall() * 0.9)
    function scroll:Paint(w, h) end
    local vbar = scroll:GetVBar()

	function vbar:Paint(w, h)
		
	end
	
	function vbar.btnUp:Paint(w, h)
		draw.RoundedBox(2, w / 2 - 1, 0, 2, h - 2, Color(0, 0, 0, 150))
	end
	
	function vbar.btnDown:Paint(w, h)
		draw.RoundedBox(2, w / 2 - 1, 2, 2, h, Color(0, 0, 0, 150))
	end
	
	function vbar.btnGrip:Paint(w, h)
		draw.RoundedBox(2, w / 2 - 1, 0, 2, h, Color(0, 0, 0, 220))
	end

    for k, v in pairs(player.GetAll()) do
        local pp = vgui.Create("DButton", scroll)
        pp:SetSize(0, 30)
        pp:Dock(TOP)
        pp:DockMargin(25, 5, 5, 5)
        pp:SetText("")
        pp.Paint = function(s, w, h)
            surface.SetDrawColor(70, 70, 70, 50)
            surface.DrawRect(0, 0, w, h)
            surface.SetDrawColor(0, 0, 0, 150)
            surface.DrawOutlinedRect(0, 0, w, h)
            draw.SimpleText(v:Nick(), "oawc.escT.25", w / 2, h / 2, Color(200, 200, 200, 200), 1, 1)
        end 
        pp.DoClick = function()
            if (v:IsBot() or !IsValid(v)) then chat.AddText(Color(116,0,0),"[OAWC - ERROR] ",Color(255,255,255),"Profil konnte nicht Geöffnet werden") return end
            v:ShowProfile()
        end
        pp.DoRightClick = function()
            if (v:IsBot() ) then chat.AddText(Color(116,0,0),"[OAWC - ERROR] ",Color(255,255,255),"SteamID konnte nicht Kopiert werden") return end
            chat.AddText(Color(25,155,5),"[OAWC] ",Color(255,255,255),"SteamID erfolgreich Kopiert!")
            SetClipboardText(v:SteamID())
        end
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

        timer.Simple(1.5, function()
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
