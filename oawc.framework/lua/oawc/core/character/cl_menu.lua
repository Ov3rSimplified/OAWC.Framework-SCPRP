--[[
 _______  _______           _______      _______  _______  _______  _______  _______           _______  _______  _
(  ___  )(  ___  )|\     /|(  ____ \    (  ____ \(  ____ )(  ___  )(       )(  ____ \|\     /|(  ___  )(  ____ )| \    /\
| (   ) || (   ) || )   ( || (    \/    | (    \/| (    )|| (   ) || () () || (    \/| )   ( || (   ) || (    )||  \  / /
| |   | || (___) || | _ | || |          | (__    | (____)|| (___) || || || || (__    | | _ | || |   | || (____)||  (_/ /
| |   | ||  ___  || |( )| || |          |  __)   |     __)|  ___  || |(_)| ||  __)   | |( )| || |   | ||     __)|   _ (
| |   | || (   ) || || || || |          | (      | (\ (   | (   ) || |   | || (      | || || || |   | || (\ (   |  ( \ \
| (___) || )   ( || () () || (____/\    | )      | ) \ \__| )   ( || )   ( || (____/\| () () || (___) || ) \ \__|  /  \ \
(_______)|/     \|(_______)(_______/    |/       |/   \__/|/     \||/     \|(_______/(_______)(_______)|/   \__/|_/    \/


-- Informations!
-- Author: TwinKlee
-- Startday: 27.06.2022 / 14:23
-- FRAMEWORK FOR THE OAWC SCPRP !!
-- YOUR NOT ALLOWED TO EDIT OR LEAK OR REUPLOAD THIS WITHOUT MY RELEASE !!
]]
OAWC:RegisterFont("OAWC.CHS.Test", {
    font = "Arial",
    size = ScrH() * 0.04,
    extended = false,
    weight = 1000,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
})
OAWC:RegisterFont("OAWC.CHS.TopTitle", {
    font = "Bauhaus Md BT",
    size = ScrH() * 0.09,
    extended = false,
    weight = 1000,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
})
OAWC:RegisterFont("OAWC.CHS.TopSubTitle", {
    font = "Bauhaus Md BT",
    size = ScrH() * 0.06,
    extended = false,
    weight = 1000,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = true,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
})
OAWC:RegisterFont("OAWC.CHS.CreateTop", {
    font = "Bauhaus Md BT",
    size = ScrH() * 0.035,
    extended = true,
    weight = 1000,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
})
OAWC:RegisterFont("OAWC.CHS.CreateCreate", {
    font = "Arial",
    size = ScrH() * 0.03,
    extended = true,
    weight = 1000,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
})
OAWC:RegisterFont("OAWC.CHS.CreateInfo", {
    font = "Bauhaus Md BT",
    size = ScrH() * 0.03,
    extended = true,
    weight = 1000,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
})
OAWC:RegisterFont("OAWC.CHS.CreateCreateTop", {
    font = "Bauhaus Md BT",
    size = ScrH() * 0.063,
    extended = false,
    weight = 1000,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
})
OAWC:RegisterFont("OAWC.CHS.CreateCreateContent", {
    font = "Montserrat",
    size = ScrH() * 0.033,
    extended = false,
    weight = 1000,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
})


local logos = {
    oawc = Material("materials/oawc/logos/oawc.png"),
    foundation = Material("materials/oawc/logos/oawc_fdplogo.png"),
    dclass = Material("materials/oawc/logos/oawc_dcplogo.png"),
    scp = Material("materials/oawc/logos/oawc_scplogo.png"),
}

timer.Simple(1, function()
    OAWC.Charactersystem.UI:OpenBeforeMenu()
end)

function OAWC.Charactersystem.UI:OpenBeforeMenu()
    local scrw, scrh = ScrW(), ScrH()
    local Color = Color

    if LocalPlayer().CharacterID == nil or LocalPlayer().CharacterID == 0 then
        if IsValid(OAWC.Charactersystem.UI.Menu) then
            return
        else
            OAWC.Charactersystem.UI:MainMenu()
        end
    end
end

function OAWC.Charactersystem.UI:MainMenu()
    local scrw, scrh = ScrW(), ScrH()
    local Color = Color
    OAWC.Charactersystem.UI.Selection = {}
    OAWCS = OAWC.Charactersystem.UI.Selection

        self.Menu = vgui.Create("DFrame")
        self.Menu:SetSize(scrw,scrh)
        self.Menu:Center()
        self.Menu:MakePopup()
        self.Menu.Paint = function(self,w,h)
            draw.RoundedBox(0,0,0,ScrW(),ScrH(),Color(0,0,0,200))
            OAWC.L:DrawBlurRect(0,0,ScrW(),ScrH(), 10, 20)

            if (!self.scrollid or self.scrollid > 0) then
                self.scrollid = OAWC.L:SimpleScrollingText(self.scrollid, "Charakterauswahl", "OAWC.CHS.TopTitle", ScrW() * 0.0, ScrH() * 0.04, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            else
                draw.SimpleText("Charakterauswahl", "OAWC.CHS.TopTitle", ScrW() * 0.0, ScrH() * 0.04, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end

            draw.RoundedBoxEx(90,0,ScrH() * 0.08,ScrW() * 0.35,ScrH() * 0.001,Color(255,255,255,255),false,true,false,true)
        end

        self.TaskMenu = vgui.Create("DScrollPanel",self.Menu)
        self.TaskMenu:SetSize(scrw*0.18,scrh)
        self.TaskMenu:SetPos(scrw*0.02,scrh*0.11)
        local sbar = self.TaskMenu:GetVBar()
        sbar:SetSize(1,0)
        sbar:SetHideButtons( true )
        function sbar.btnGrip:Paint(w, h) return end
        function sbar:Paint(w, h) return end
        function sbar.btnUp:Paint(w, h) return end
        function sbar.btnDown:Paint(w, h) return end

    local function task()

        net.Start("OAWC.CharSys.RequestPlayerCharacter")
        net.SendToServer()

        timer.Simple(0.9, function()
            --[[
                FDP - C/S Char
            ]]
            local items = {
                ["FDP"] = {
                    kind = "FDP",
                    order = 1,
                    title = "Foundation Personal",
                    img = logos.foundation,
                    p = {}
                },
                ["DCP"] = {
                    kind = "DCP",
                    order = 2,
                    title = "DClass Personal",
                    img = logos.dclass,
                    p = {}
                },
                ["SCP"] = {
                    kind = "SCP",
                    order = 3,
                    title = "SCP OBJECT",
                    img = logos.scp,
                    p = {}
                },

            }
            for k,v in SortedPairsByMemberValue(items, "order", false ) do
                local p = v.p 
                p.Panel = vgui.Create("DPanel",self.TaskMenu)
                p.Panel:Dock(TOP)
                p.Panel:DockMargin(0,10,0,0)
                p.Panel:SetText("")
                p.Panel:SetTall(scrh*0.28)
                p.Panel:SetAlpha( 0 )
                p.Panel:AlphaTo( 255, 0.85, 0 )
                p.Panel.Hover = false
                p.Panel.Color = Color(53,53,53,255)
                p.Panel.Paint = function(self,w,h)
                    draw.RoundedBox(15,0,0,w,h,p.Panel.Color)
                    draw.RoundedBox(15,2,2,w-4,h-4,Color(53,53,53,255))
                end

                p.Top = vgui.Create("DLabel",p.Panel)
                p.Top:Dock(TOP)
                p.Top:DockMargin(0,0,0,0)
                p.Top:SetTall(scrh*0.050)
                p.Top:SetText("")
                local txt1 = v.title
                p.Top.Paint = function(self,w,h)
                    if LocalPlayer().Characters[v.kind] then
                        txt1 = LocalPlayer().Characters[v.kind].name
                    else
                        txt1 = v.title
                    end

                    if (!self.scrollid or self.scrollid > 0) then
                        self.scrollid = OAWC.L:SimpleScrollingText(self.scrollid, txt1, "OAWC.CHS.CreateTop", w/2, h/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                    else
                        draw.SimpleText(txt1, "OAWC.CHS.CreateTop", w/2, h/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                end

                p.MP = vgui.Create("DPanel",p.Panel)
                p.MP:Dock(FILL)
                p.MP:DockMargin(10,0,10,10)
                p.MP.Paint = function(self,w,h)
                    draw.RoundedBox(15,0,0,w,h,Color(68,68,68))
                end

                p.Logo = vgui.Create("DImage",p.Panel)
                p.Logo:Dock(FILL)
                p.Logo:DockMargin(20,scrh*0.02,20,scrh*0.02)
                p.Logo:SetMaterial(v.img)

                if not table.IsEmpty(LocalPlayer().Characters) then
                    if LocalPlayer().Characters then
                        if v.kind == "FDP" and LocalPlayer().Characters["FDP"] or v.kind == "DCP" and LocalPlayer().Characters["DCP"] then
                            p.Delete = vgui.Create("DButton",p.Panel)
                            p.Delete:SetSize(scrw*0.015, scrh*0.020)
                            p.Delete:SetPos(scrw*0.159,scrh*0.012)
                            p.Delete:SetText("X")
                            p.Delete.DoClick = function()
                                net.Start("OAWC.CharSys.DeleteCharacter")
                                net.WriteInt(LocalPlayer().Characters[v.kind].id,32)
                                net.SendToServer()

                                self.TaskMenu:Clear()
                                task()
                            end
                            p.Delete.Paint = function(self,w,h)
                                draw.RoundedBox(50,0,0,w,h,Color(255,0,0))
                                if self:IsHovered() then
                                    p.Panel.Color = Color(255,0,0,255)
                                else
                                    p.Panel.Color = Color(53,53,53,255)
                                end
                            end
                        end
                    end
                end

                p.Create = vgui.Create("DButton",p.Panel)
                p.Create:Dock(BOTTOM)
                p.Create:DockMargin(10,0,10,10)
                p.Create:SetTextColor(Color(255,255,255))
                p.Create:SetFont("OAWC.CHS.CreateCreate")
                p.Create:SetTall(scrh*0.03)
                p.Create.Paint = function(self,w,h)
                    local btnc = Color(50,205,65)

                    if items["SCP"] and v.kind == "SCP" then
                        if table.IsEmpty(LocalPlayer().Characters) then 
                            self:SetText("GESPERRT")
                            btnc = Color(255,0,0)
                        else
                            if not LocalPlayer().Characters["FDP"] or LocalPlayer().Characters["DCP"] then
                                self:SetText("GESPERRT")
                                btnc = Color(255,0,0)
                            end
                            btnc = Color(50,205,65)
                            self:SetText("SPIELEN")
                        end
                    end

                    draw.RoundedBox(15,0,0,w,h,btnc)

                    if self:IsHovered() then
                        p.Panel.Color = Color(238,143,10)
                    else
                        p.Panel.Color = Color(53,53,53,255)
                    end
                    if table.IsEmpty(LocalPlayer().Characters) then 
                        self:SetText("ERSTELLEN")
                    else
                        if not LocalPlayer().Characters then
                            self:SetText("ERSTELLEN")
                        else
                            if LocalPlayer().Characters[v.kind] then
                                self:SetText("SPIELEN")
                            else
                                self:SetText("ERSTELLEN")
                            end
                        end
                    end

                    if items["SCP"] and v.kind == "SCP" then
                        if table.IsEmpty(LocalPlayer().Characters) then 
                            self:SetText("GESPERRT")
                        else
                            if not LocalPlayer().Characters then
                                self:SetText("GESPERRT")
                            end
                            self:SetText("SPIELEN")
                        end
                    end

                end
                p.Create.DoClick = function()

                    local function CreateCharacter(category)
                        local Panel = vgui.Create("DFrame", self.Menu)
                        Panel:SetSize(scrw*0.5,scrh*0.8)
                        Panel:SetPos(scrw*0.25,scrh*0.12)
                        Panel:SetTitle("")
                        Panel:MakePopup()
                        Panel:SetDraggable(false)
                        Panel:ShowCloseButton(false)
                        Panel:DoModal()

                        Panel.Paint = function(self,w,h)
                            draw.RoundedBox(15,0,0,w,h,Color(68,68,68))
                            draw.RoundedBox(15,2,2,w-4,h-4,Color(53,53,53,255))

                            if (!self.scrollid or self.scrollid > 0) then
                                self.scrollid = OAWC.L:SimpleScrollingText(self.scrollid, "Charakter Erstellen", "OAWC.CHS.CreateCreateTop", scrw*0.01, scrh*0.04, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                            else
                                draw.SimpleText("Charakter Erstellen", "OAWC.CHS.CreateCreateTop", scrw*0.01, scrh*0.04, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                            end
                            draw.RoundedBoxEx(90,0,ScrH() * 0.08,ScrW() * 0.35,ScrH() * 0.001,Color(255,255,255,255),false,true,false,true)

                        end

                        local Closebutton = vgui.Create("DButton", Panel)
                        Closebutton:SetSize(scrw*0.05,scrh*0.05)
                        Closebutton:SetPos(scrw*0.445,scrh*0.01)
                        Closebutton:SetText("")
                        Closebutton.Paint = function(self,w,h)
                            draw.RoundedBox(7.5,0,0,w,h,Color(0, 0, 0, 150))
                            self.alpha = self.alpha or 0
                            if self:IsHovered() then
                                self.alpha = Lerp(FrameTime()*3, self.alpha, 1)
                            else
                                self.alpha = Lerp(FrameTime()*6, self.alpha, 0)
                            end
                            draw.RoundedBox(7.5,0,0,w,h,Color(255, 255, 255, 35*self.alpha))

                            draw.SimpleText("X", "OAWC.CHS.CreateCreate", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        end
                        Closebutton.DoClick = function()
                            Panel:Remove()
                        end


                        local Scroll = vgui.Create("DScrollPanel", Panel)
                        Scroll:Dock(FILL)
                        Scroll:DockMargin(0,scrh*0.055,10,10)

                        local content = {}

                        content.NamePanel = vgui.Create("DPanel",Scroll)
                        content.NamePanel:Dock(TOP)
                        content.NamePanel:SetTall(scrh*0.07)
                        content.NamePanel.Paint = nil

                        content.NamePanel.Label = vgui.Create("DLabel",content.NamePanel)
                        content.NamePanel.Label:Dock(LEFT)
                        content.NamePanel.Label:SetWide(scrw*0.13)
                        content.NamePanel.Label:SetText("Name:")
                        content.NamePanel.Label:SetTextColor(Color(255,255,255))
                        content.NamePanel.Label:SetFont("OAWC.CHS.CreateCreateContent")

                        content.NamePanel.TextEntry =  OAWC.L:CreateTextField(content.NamePanel)
                        content.NamePanel.TextEntry:Dock(FILL)
                        content.NamePanel.TextEntry:DockMargin(0,scrh*0.014,scrw*0.14,scrh*0.014)
                        content.NamePanel.TextEntry:SetPlaceholderText("Namen Eingeben")
                        content.NamePanel.TextEntry:SetTooltip("Mit einem LINKS Click auf dem Titel, bekommst du genaueres!")
                        content.NamePanel.TextEntry.Rounded = 7.5


                        content.GenderPanel = vgui.Create("DPanel",Scroll)
                        content.GenderPanel:Dock(TOP)
                        content.GenderPanel:SetTall(scrh*0.07)
                        content.GenderPanel.Paint = nil
                        content.GenderPanel.Gender = ""

                        content.GenderPanel.Label = vgui.Create("DLabel",content.GenderPanel)
                        content.GenderPanel.Label:Dock(LEFT)
                        content.GenderPanel.Label:SetWide(scrw*0.13)
                        content.GenderPanel.Label:SetText("Geschlecht:")
                        content.GenderPanel.Label:SetTextColor(Color(255,255,255))
                        content.GenderPanel.Label:SetFont("OAWC.CHS.CreateCreateContent")

                        content.GenderPanel.sp =  vgui.Create("DPanel", content.GenderPanel )
                        content.GenderPanel.sp:Dock(FILL)
                        content.GenderPanel.sp:DockMargin(0,scrh*0.014,scrw*0.14,scrh*0.014)
                        content.GenderPanel.sp.Paint = function(self,w,h)
                            draw.RoundedBox(7.5,0,0,w,h,Color(0, 0, 0, 150))
                            draw.RoundedBox(0,w/2,0,1,h,Color(255, 255, 255, 255))
                        end

                        content.GenderPanel.sp.Male = vgui.Create("DButton", content.GenderPanel.sp )
                        content.GenderPanel.sp.Male:Dock(LEFT)
                        content.GenderPanel.sp.Male:DockMargin(0,0,0,0)
                        content.GenderPanel.sp.Male:SetWide(scrw*0.11)
                        content.GenderPanel.sp.Male:SetText("Männlich")
                        content.GenderPanel.sp.Male:SetFont("OAWC.CHS.CreateCreateContent")
                        content.GenderPanel.sp.Male:SetTextColor(Color(255,255,255))
                        content.GenderPanel.sp.Male.Clicked = false
                        content.GenderPanel.sp.Male.Paint = function(self,w,h)
                            self.alpha = self.alpha or 0
                            if self:IsHovered() then
                                self.alpha = Lerp(FrameTime()*3, self.alpha, 1)
                            else
                                self.alpha = Lerp(FrameTime()*6, self.alpha, 0)
                            end
                            draw.RoundedBoxEx(7.5,0,0,w,h,Color(255, 255, 255, 35*self.alpha), true,false,true,false)

                            if content.GenderPanel.sp.Male.Clicked then
                                draw.RoundedBoxEx(7.5,0,0,w,h,Color(255, 209, 55,120), true,false,true,false)
                            end
                        end
                        content.GenderPanel.sp.Male.DoClick = function()
                            surface.PlaySound("items/nvg_off.wav")
                            content.GenderPanel.sp.Male.Clicked = true
                            content.GenderPanel.sp.FeMale.Clicked = false
                            content.GenderPanel.Gender = "Male"
                        end
                        content.GenderPanel.sp.Male.OnCursorEntered = function(self)
                            surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav")
                        end

                        content.GenderPanel.sp.FeMale = vgui.Create("DButton", content.GenderPanel.sp )
                        content.GenderPanel.sp.FeMale:Dock(RIGHT)
                        content.GenderPanel.sp.FeMale:DockMargin(0,0,0,0)
                        content.GenderPanel.sp.FeMale:SetWide(scrw*0.11)
                        content.GenderPanel.sp.FeMale:SetText("Weiblich")
                        content.GenderPanel.sp.FeMale:SetFont("OAWC.CHS.CreateCreateContent")
                        content.GenderPanel.sp.FeMale:SetTextColor(Color(255,255,255))
                        content.GenderPanel.sp.FeMale.Clicked = false
                        content.GenderPanel.sp.FeMale.Paint = function(self,w,h)
                            self.alpha = self.alpha or 0
                            if self:IsHovered() then
                                self.alpha = Lerp(FrameTime()*3, self.alpha, 1)
                            else
                                self.alpha = Lerp(FrameTime()*6, self.alpha, 0)
                            end
                            draw.RoundedBoxEx(7.5,0,0,w,h,Color(255, 255, 255, 35*self.alpha), false,true,false,true)

                            if content.GenderPanel.sp.FeMale.Clicked then
                                draw.RoundedBoxEx(7.5,0,0,w,h,Color(255, 209, 55,120), false,true,false,true)
                            end
                        end
                        content.GenderPanel.sp.FeMale.DoClick = function()
                            surface.PlaySound("items/nvg_off.wav")
                            content.GenderPanel.sp.Male.Clicked = false
                            content.GenderPanel.sp.FeMale.Clicked = true
                            content.GenderPanel.Gender = "Female"
                        end
                        content.GenderPanel.sp.FeMale.OnCursorEntered = function(self)
                            surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav")
                        end

                        content.AgePanel = vgui.Create("DPanel",Scroll)
                        content.AgePanel:Dock(TOP)
                        content.AgePanel:SetTall(scrh*0.07)
                        content.AgePanel.Paint = nil

                        content.AgePanel.Label = vgui.Create("DLabel",content.AgePanel)
                        content.AgePanel.Label:Dock(LEFT)
                        content.AgePanel.Label:SetWide(scrw*0.13)
                        content.AgePanel.Label:SetText("Alter(18-40):")
                        content.AgePanel.Label:SetTextColor(Color(255,255,255))
                        content.AgePanel.Label:SetFont("OAWC.CHS.CreateCreateContent")

                        content.AgePanel.TextEntry =  OAWC.L:CreateTextField(content.AgePanel)
                        content.AgePanel.TextEntry:Dock(FILL)
                        content.AgePanel.TextEntry:DockMargin(0,scrh*0.014,scrw*0.14,scrh*0.014)
                        content.AgePanel.TextEntry:SetPlaceholderText("Alter Eingeben")
                        content.AgePanel.TextEntry.Rounded = 7.5
                        content.AgePanel.TextEntry.OnEnter = function(self)
                            if tonumber(self:GetText()) == nil then
                                surface.PlaySound("buttons/weapon_cant_buy.wav")
                                self:SetText("0")
                            end

                            if tonumber(self:GetText()) < OAWC.Config.Humans.MinCreateAge then
                                surface.PlaySound("buttons/weapon_cant_buy.wav")
                                self:SetText(tostring(OAWC.Config.Humans.MinCreateAge))
                            end

                            if tonumber(self:GetText()) > OAWC.Config.Humans.MaxCreateAge then
                                surface.PlaySound("buttons/weapon_cant_buy.wav")
                                self:SetText(tostring(OAWC.Config.Humans.MaxCreateAge))
                            end
                        end

                        content.WeightPanel = vgui.Create("DPanel",Scroll)
                        content.WeightPanel:Dock(TOP)
                        content.WeightPanel:SetTall(scrh*0.07)
                        content.WeightPanel.Paint = nil

                        content.WeightPanel.Label = vgui.Create("DLabel",content.WeightPanel)
                        content.WeightPanel.Label:Dock(LEFT)
                        content.WeightPanel.Label:SetWide(scrw*0.13)
                        content.WeightPanel.Label:SetText("Gewicht(45-200):")
                        content.WeightPanel.Label:SetTextColor(Color(255,255,255))
                        content.WeightPanel.Label:SetFont("OAWC.CHS.CreateCreateContent")

                        content.WeightPanel.TextEntry =  OAWC.L:CreateTextField(content.WeightPanel)
                        content.WeightPanel.TextEntry:Dock(FILL)
                        content.WeightPanel.TextEntry:DockMargin(0,scrh*0.014,scrw*0.14,scrh*0.014)
                        content.WeightPanel.TextEntry:SetPlaceholderText("Gewicht Eingeben(kg)")
                        content.WeightPanel.TextEntry.Rounded = 7.5
                        content.WeightPanel.TextEntry.OnEnter = function(self)
                            if tonumber(self:GetText()) == nil then
                                surface.PlaySound("buttons/weapon_cant_buy.wav")
                                self:SetText("0")
                            end
                            if tonumber(self:GetText()) < OAWC.Config.Humans.MinCreateWeight then
                                surface.PlaySound("buttons/weapon_cant_buy.wav")
                                self:SetText(tostring(OAWC.Config.Humans.MinCreateWeight))
                            end

                            if tonumber(self:GetText()) > OAWC.Config.Humans.MaxCreateWeight then
                                surface.PlaySound("buttons/weapon_cant_buy.wav")
                                self:SetText(tostring(OAWC.Config.Humans.MaxCreateWeight))
                            end
                        end


                        --[[
                                Chooose Attribute!
                        ]]
                        content.Attribute = 10
                        content.ResistancePoints = 0
                        content.StrongPoints = 0
                        content.SpeedPoints = 0
                        content.StaminaPoints = 0

                        content.Attribute_Label = vgui.Create("DLabel",Scroll)
                        content.Attribute_Label:Dock(TOP)
                        content.Attribute_Label:SetTall(scrh*0.039)
                        content.Attribute_Label:SetFont("OAWC.CHS.CreateCreateContent")
                        content.Attribute_Label:SetTextColor(Color(255,255,255))
                        content.Attribute_Label.Paint = function(self,w,h)
                            self:SetText("Attribute:     (" .. content.Attribute .. ")")
                            draw.RoundedBoxEx(90,0,scrh*0.035,scrw * 0.35,1,Color(255,255,255,255),false,true,false,true)
                        end


                        content.ResistancePanel  = vgui.Create("DPanel",Scroll)
                        content.ResistancePanel:Dock(TOP)
                        content.ResistancePanel:SetTall(scrh*0.07)
                        content.ResistancePanel.Paint = nil

                        content.ResistancePanel.Label = vgui.Create("DLabel",content.ResistancePanel)
                        content.ResistancePanel.Label:Dock(LEFT)
                        content.ResistancePanel.Label:SetWide(scrw*0.13)
                        content.ResistancePanel.Label:SetText("Resistenz:")
                        content.ResistancePanel.Label:SetTextColor(Color(255,255,255))
                        content.ResistancePanel.Label:SetFont("OAWC.CHS.CreateCreateContent")

                        content.ResistancePanel.p =  vgui.Create("DPanel", content.ResistancePanel )
                        content.ResistancePanel.p:Dock(FILL)
                        content.ResistancePanel.p:DockMargin(0,scrh*0.014,scrw*0.14,scrh*0.014)
                        content.ResistancePanel.p.Paint = function(self,w,h)
                            draw.RoundedBox(7.5,0,0,w,h,Color(0, 0, 0, 150))
                            draw.RoundedBox(10,0,0,w * (content.ResistancePoints / 10),h,Color(255, 209, 55,120))

                            draw.SimpleText("(".. content.ResistancePoints .. "/" .. "10)", "OAWC.CHS.CreateCreateContent", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        end

                        content.ResistancePanel.p.minus = vgui.Create("DButton", content.ResistancePanel.p)
                        content.ResistancePanel.p.minus:Dock(LEFT)
                        content.ResistancePanel.p.minus:SetWide(scrw*0.02)
                        content.ResistancePanel.p.minus:SetText("-")
                        content.ResistancePanel.p.minus:SetTextColor(Color(255,255,255))
                        content.ResistancePanel.p.minus:SetFont("OAWC.CHS.CreateCreateContent")
                        content.ResistancePanel.p.minus.DoClick = function()
                            if content.ResistancePoints < 0 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            if content.ResistancePoints == 0 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            surface.PlaySound("items/nvg_off.wav")
                            content.Attribute = content.Attribute + 1
                            content.ResistancePoints = content.ResistancePoints - 1
                        end
                        content.ResistancePanel.p.minus.Paint = nil
                        content.ResistancePanel.p.minus.OnCursorEntered = function(self)
                            surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav")
                        end

                        content.ResistancePanel.p.plus = vgui.Create("DButton", content.ResistancePanel.p)
                        content.ResistancePanel.p.plus:Dock(RIGHT)
                        content.ResistancePanel.p.plus:SetWide(scrw*0.02)
                        content.ResistancePanel.p.plus:SetText("+")
                        content.ResistancePanel.p.plus:SetTextColor(Color(255,255,255))
                        content.ResistancePanel.p.plus:SetFont("OAWC.CHS.CreateCreateContent")
                        content.ResistancePanel.p.plus.DoClick = function()
                            if content.Attribute == 0 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            if content.ResistancePoints > 10 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            if content.ResistancePoints == 10 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            surface.PlaySound("items/nvg_off.wav")
                            content.Attribute = content.Attribute - 1
                            content.ResistancePoints = content.ResistancePoints + 1
                        end
                        content.ResistancePanel.p.plus.Paint = nil
                        content.ResistancePanel.p.plus.OnCursorEntered = function(self)
                            surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav")
                        end

                        content.StrongPanel  = vgui.Create("DPanel",Scroll)
                        content.StrongPanel:Dock(TOP)
                        content.StrongPanel:SetTall(scrh*0.07)
                        content.StrongPanel.Paint = nil

                        content.StrongPanel.Label = vgui.Create("DLabel",content.StrongPanel)
                        content.StrongPanel.Label:Dock(LEFT)
                        content.StrongPanel.Label:SetWide(scrw*0.13)
                        content.StrongPanel.Label:SetText("Stärke:")
                        content.StrongPanel.Label:SetTextColor(Color(255,255,255))
                        content.StrongPanel.Label:SetFont("OAWC.CHS.CreateCreateContent")

                        content.StrongPanel.p =  vgui.Create("DPanel", content.StrongPanel )
                        content.StrongPanel.p:Dock(FILL)
                        content.StrongPanel.p:DockMargin(0,scrh*0.014,scrw*0.14,scrh*0.014)
                        content.StrongPanel.p.Paint = function(self,w,h)
                            draw.RoundedBox(7.5,0,0,w,h,Color(0, 0, 0, 150))
                            draw.RoundedBox(10,0,0,w * (content.StrongPoints / 10),h,Color(255, 209, 55,120))

                            draw.SimpleText("(".. content.StrongPoints .. "/" .. "10)", "OAWC.CHS.CreateCreateContent", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        end

                        content.StrongPanel.p.minus = vgui.Create("DButton", content.StrongPanel.p)
                        content.StrongPanel.p.minus:Dock(LEFT)
                        content.StrongPanel.p.minus:SetWide(scrw*0.02)
                        content.StrongPanel.p.minus:SetText("-")
                        content.StrongPanel.p.minus:SetTextColor(Color(255,255,255))
                        content.StrongPanel.p.minus:SetFont("OAWC.CHS.CreateCreateContent")
                        content.StrongPanel.p.minus.DoClick = function()
                            if content.StrongPoints < 0 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            if content.StrongPoints == 0 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            surface.PlaySound("items/nvg_off.wav")
                            content.Attribute = content.Attribute + 1
                            content.StrongPoints = content.StrongPoints - 1
                        end
                        content.StrongPanel.p.minus.Paint = nil
                        content.StrongPanel.p.minus.OnCursorEntered = function(self)
                            surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav")
                        end

                        content.StrongPanel.p.plus = vgui.Create("DButton", content.StrongPanel.p)
                        content.StrongPanel.p.plus:Dock(RIGHT)
                        content.StrongPanel.p.plus:SetWide(scrw*0.02)
                        content.StrongPanel.p.plus:SetText("+")
                        content.StrongPanel.p.plus:SetTextColor(Color(255,255,255))
                        content.StrongPanel.p.plus:SetFont("OAWC.CHS.CreateCreateContent")
                        content.StrongPanel.p.plus.DoClick = function()
                            if content.Attribute == 0 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            if content.StrongPoints > 10 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            if content.StrongPoints == 10 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            surface.PlaySound("items/nvg_off.wav")
                            content.Attribute = content.Attribute - 1
                            content.StrongPoints = content.StrongPoints + 1
                        end
                        content.StrongPanel.p.plus.Paint = nil
                        content.StrongPanel.p.plus.OnCursorEntered = function(self)
                            surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav")
                        end


                        content.SpeedPanel  = vgui.Create("DPanel",Scroll)
                        content.SpeedPanel:Dock(TOP)
                        content.SpeedPanel:SetTall(scrh*0.07)
                        content.SpeedPanel.Paint = nil

                        content.SpeedPanel.Label = vgui.Create("DLabel",content.SpeedPanel)
                        content.SpeedPanel.Label:Dock(LEFT)
                        content.SpeedPanel.Label:SetWide(scrw*0.13)
                        content.SpeedPanel.Label:SetText("Schnelligkeit:")
                        content.SpeedPanel.Label:SetTextColor(Color(255,255,255))
                        content.SpeedPanel.Label:SetFont("OAWC.CHS.CreateCreateContent")

                        content.SpeedPanel.p =  vgui.Create("DPanel", content.SpeedPanel )
                        content.SpeedPanel.p:Dock(FILL)
                        content.SpeedPanel.p:DockMargin(0,scrh*0.014,scrw*0.14,scrh*0.014)
                        content.SpeedPanel.p.Paint = function(self,w,h)
                            draw.RoundedBox(7.5,0,0,w,h,Color(0, 0, 0, 150))
                            draw.RoundedBox(10,0,0,w * (content.SpeedPoints / 10),h,Color(255, 209, 55,120))
                            draw.SimpleText("(".. content.SpeedPoints .. "/" .. "10)", "OAWC.CHS.CreateCreateContent", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        end

                        content.SpeedPanel.p.minus = vgui.Create("DButton", content.SpeedPanel.p)
                        content.SpeedPanel.p.minus:Dock(LEFT)
                        content.SpeedPanel.p.minus:SetWide(scrw*0.02)
                        content.SpeedPanel.p.minus:SetText("-")
                        content.SpeedPanel.p.minus:SetTextColor(Color(255,255,255))
                        content.SpeedPanel.p.minus:SetFont("OAWC.CHS.CreateCreateContent")
                        content.SpeedPanel.p.minus.DoClick = function()
                            if content.SpeedPoints < 0 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            if content.SpeedPoints == 0 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            surface.PlaySound("items/nvg_off.wav")
                            content.Attribute = content.Attribute + 1
                            content.SpeedPoints = content.SpeedPoints - 1
                        end
                        content.SpeedPanel.p.minus.Paint = nil
                        content.SpeedPanel.p.minus.OnCursorEntered = function(self)
                            surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav")
                        end


                        content.SpeedPanel.p.plus = vgui.Create("DButton", content.SpeedPanel.p)
                        content.SpeedPanel.p.plus:Dock(RIGHT)
                        content.SpeedPanel.p.plus:SetWide(scrw*0.02)
                        content.SpeedPanel.p.plus:SetText("+")
                        content.SpeedPanel.p.plus:SetTextColor(Color(255,255,255))
                        content.SpeedPanel.p.plus:SetFont("OAWC.CHS.CreateCreateContent")
                        content.SpeedPanel.p.plus.DoClick = function()
                            if content.Attribute == 0 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            if content.SpeedPoints > 10 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            if content.SpeedPoints == 10 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            surface.PlaySound("items/nvg_off.wav")
                            content.Attribute = content.Attribute - 1
                            content.SpeedPoints = content.SpeedPoints + 1
                        end
                        content.SpeedPanel.p.plus.Paint = nil
                        content.SpeedPanel.p.plus.OnCursorEntered = function(self)
                            surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav")
                        end




                        content.StaminaPanel  = vgui.Create("DPanel",Scroll)
                        content.StaminaPanel:Dock(TOP)
                        content.StaminaPanel:SetTall(scrh*0.07)
                        content.StaminaPanel.Paint = nil

                        content.StaminaPanel.Label = vgui.Create("DLabel",content.StaminaPanel)
                        content.StaminaPanel.Label:Dock(LEFT)
                        content.StaminaPanel.Label:SetWide(scrw*0.13)
                        content.StaminaPanel.Label:SetText("Ausdauer:")
                        content.StaminaPanel.Label:SetTextColor(Color(255,255,255))
                        content.StaminaPanel.Label:SetFont("OAWC.CHS.CreateCreateContent")

                        content.StaminaPanel.p =  vgui.Create("DPanel", content.StaminaPanel )
                        content.StaminaPanel.p:Dock(FILL)
                        content.StaminaPanel.p:DockMargin(0,scrh*0.014,scrw*0.14,scrh*0.014)
                        content.StaminaPanel.p.Paint = function(self,w,h)
                            draw.RoundedBox(7.5,0,0,w,h,Color(0, 0, 0, 150))
                            draw.RoundedBox(10,0,0,w * (content.StaminaPoints / 10),h,Color(255, 209, 55,120))
                            draw.SimpleText("(".. content.StaminaPoints .. "/" .. "10)", "OAWC.CHS.CreateCreateContent", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        end

                        content.StaminaPanel.p.minus = vgui.Create("DButton", content.StaminaPanel.p)
                        content.StaminaPanel.p.minus:Dock(LEFT)
                        content.StaminaPanel.p.minus:SetWide(scrw*0.02)
                        content.StaminaPanel.p.minus:SetText("-")
                        content.StaminaPanel.p.minus:SetTextColor(Color(255,255,255))
                        content.StaminaPanel.p.minus:SetFont("OAWC.CHS.CreateCreateContent")
                        content.StaminaPanel.p.minus.DoClick = function()
                            if content.StaminaPoints < 0 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            if content.StaminaPoints == 0 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            surface.PlaySound("items/nvg_off.wav")
                            content.Attribute = content.Attribute + 1
                            content.StaminaPoints = content.StaminaPoints - 1
                        end
                        content.StaminaPanel.p.minus.Paint = nil
                        content.StaminaPanel.p.minus.OnCursorEntered = function(self)
                            surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav")
                        end

                        content.StaminaPanel.p.plus = vgui.Create("DButton", content.StaminaPanel.p)
                        content.StaminaPanel.p.plus:Dock(RIGHT)
                        content.StaminaPanel.p.plus:SetWide(scrw*0.02)
                        content.StaminaPanel.p.plus:SetText("+")
                        content.StaminaPanel.p.plus:SetTextColor(Color(255,255,255))
                        content.StaminaPanel.p.plus:SetFont("OAWC.CHS.CreateCreateContent")
                        content.StaminaPanel.p.plus.DoClick = function()
                            if content.Attribute == 0 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            if content.StaminaPoints > 10 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            if content.StaminaPoints == 10 then surface.PlaySound("buttons/weapon_cant_buy.wav") return end
                            surface.PlaySound("items/nvg_off.wav")
                            content.Attribute = content.Attribute - 1
                            content.StaminaPoints = content.StaminaPoints + 1
                        end
                        content.StaminaPanel.p.plus.Paint = nil
                        content.StaminaPanel.p.plus.OnCursorEntered = function(self)
                            surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav")
                        end



                        local Send = vgui.Create("DButton", Panel)
                        Send:Dock(BOTTOM)
                        Send:SetTall(scrh*0.07)
                        Send:SetText("E R S T E L L E N")
                        Send:SetTextColor(Color(255,255,255))
                        Send:SetFont("OAWC.CHS.CreateCreateContent")
                        Send:DockMargin(scrw*0.08,0,scrw*0.08,scrh*0.02)
                        Send.Paint = function(self,w,h)
                            draw.RoundedBox(7.5,0,0,w,h,Color(0, 0, 0, 150))
                            self.alpha = self.alpha or 0
                            if self:IsHovered() then
                                self.alpha = Lerp(FrameTime()*3, self.alpha, 1)
                            else
                                self.alpha = Lerp(FrameTime()*6, self.alpha, 0)
                            end
                            draw.RoundedBox(7.5,0,0,w,h,Color(255, 255, 255, 35*self.alpha))
                        end
                        Send.OnCursorEntered = function(self)
                            surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav")
                        end
                        Send.DoClick = function(self)

                            if content.NamePanel.TextEntry:GetText() == "" then OAWC:Notify("error", "FEHLER!", "Du musst einen Namen angeben!", 1.2) surface.PlaySound("buttons/weapon_cant_buy.wav") return end

                            if string.len(content.NamePanel.TextEntry:GetText()) < OAWC.Config.Humans.MinNameLength then OAWC:Notify("error", "FEHLER!", "Dein Name muss mindestens " .. OAWC.Config.Humans.MinNameLength .. " Zeichen beinhalten!", 1.2) surface.PlaySound("buttons/weapon_cant_buy.wav") return end

                            if string.len(content.NamePanel.TextEntry:GetText()) > OAWC.Config.Humans.MaxNameLength then OAWC:Notify("error", "FEHLER!", "Dein Name darf nicht mehr als " .. OAWC.Config.Humans.MaxNameLength .. " Zeichen beinhalten!", 1.2) surface.PlaySound("buttons/weapon_cant_buy.wav") return end

                            if content.GenderPanel.Gender == "" then OAWC:Notify("error", "FEHLER!", "Bitte wähle ein Geschlecht für deinen Charakter", 1.2) surface.PlaySound("buttons/weapon_cant_buy.wav") return end

                            if content.AgePanel.TextEntry:GetText() == "" then OAWC:Notify("error", "FEHLER!", "Bitte gib ein Alter für deinen Charakter an!", 1.2) surface.PlaySound("buttons/weapon_cant_buy.wav") return end

                            if tonumber(content.AgePanel.TextEntry:GetText()) == nil then OAWC:Notify("error", "FEHLER!", "Das Alter muss eine Zahl sein!", 1.2) surface.PlaySound("buttons/weapon_cant_buy.wav") return end

                            if tonumber(content.AgePanel.TextEntry:GetText()) < OAWC.Config.Humans.MinCreateAge then OAWC:Notify("error", "FEHLER!", "Dein Alter deines Charakters, darf nicht unter " .. OAWC.Config.Humans.MinCreateAge .." liegen!", 1.2) surface.PlaySound("buttons/weapon_cant_buy.wav") return end

                            if tonumber(content.AgePanel.TextEntry:GetText()) > OAWC.Config.Humans.MaxCreateAge then OAWC:Notify("error", "FEHLER!", "Dein Alter deines Charakters, darf nicht über " .. OAWC.Config.Humans.MaxCreateAge .." liegen!", 1.2) surface.PlaySound("buttons/weapon_cant_buy.wav") return end

                            if content.WeightPanel.TextEntry:GetText() == "" then OAWC:Notify("error", "FEHLER!", "Bitte gib ein Gewicht für deinen Charakter an!", 1.2) surface.PlaySound("buttons/weapon_cant_buy.wav") return end

                            if tonumber(content.WeightPanel.TextEntry:GetText()) == nil then OAWC:Notify("error", "FEHLER!", "Das Gewicht muss eine Zahl sein!", 1.2) surface.PlaySound("buttons/weapon_cant_buy.wav") return end

                            if tonumber(content.WeightPanel.TextEntry:GetText()) < OAWC.Config.Humans.MinCreateWeight then OAWC:Notify("error", "FEHLER!", "Das Gewicht deines Charakters darf nicht unter " .. OAWC.Config.Humans.MinCreateWeight .. " liegen", 1.2) surface.PlaySound("buttons/weapon_cant_buy.wav") return end

                            if tonumber(content.WeightPanel.TextEntry:GetText()) > OAWC.Config.Humans.MaxCreateWeight then OAWC:Notify("error", "FEHLER!", "Das Gewicht deines Charakters darf nicht über " .. OAWC.Config.Humans.MaxCreateWeight .. " liegen", 1.2) surface.PlaySound("buttons/weapon_cant_buy.wav") return end

                            local Data = {
                                name = tostring(content.NamePanel.TextEntry:GetText()),
                                age = tonumber(content.AgePanel.TextEntry:GetText()),
                                weight = tonumber(content.WeightPanel.TextEntry:GetText()),
                                gender = content.GenderPanel.Gender,
                                kind = category,
                                REP = content.ResistancePoints,
                                STP = content.StrongPoints,
                                SPP = content.SpeedPoints,
                                SAP = content.StaminaPoints,
                            }

                            net.Start("OAWC.CharSys.CreateCharacter")
                            net.WriteCompressedTable(Data)
                            net.SendToServer()

                            OAWC.Charactersystem.UI.TaskMenu:Clear()
                            task()
                            Panel:Remove()

                        end
                    end
                    -- [[ IF ]]

                    if table.IsEmpty(LocalPlayer().Characters) then 
                        if v.kind == "FDP" then
                            CreateCharacter("FDP")
                        elseif v.kind == "DCP" then
                            CreateCharacter("DCP")
                        end
                    else
                        if not LocalPlayer().Characters then
                            if v.kind == "FDP" then
                                CreateCharacter("FDP")
                            elseif v.kind == "DCP" then
                                CreateCharacter("DCP")
                            end
                        else
                            if LocalPlayer().Characters["SCP"] then
                            elseif not LocalPlayer().Characters["SCP"] and v.kind == "SCP" then
                                net.Start("OAWC.CharSys.SelectSCP")
                                net.SendToServer()
                                OAWC.Charactersystem.UI.Menu:Remove()
                            end

                            if LocalPlayer().Characters["DCP"] and v.kind == "DCP" then
                                net.Start("OAWC.CharSys.SelectCharacter")
                                net.WriteInt(LocalPlayer().Characters["DCP"].id, 32)
                                net.WriteString("DCP")
                                net.WriteString(LocalPlayer().Characters["DCP"].sid)
                                net.SendToServer()
                                OAWC.Charactersystem.UI.Menu:Remove()
                            elseif not LocalPlayer().Characters["DCP"] and v.kind == "DCP" then
                                CreateCharacter("DCP")
                            end

                            if LocalPlayer().Characters["FDP"] and v.kind == "FDP" then
                                net.Start("OAWC.CharSys.SelectCharacter")
                                net.WriteInt(LocalPlayer().Characters["FDP"].id, 32)
                                net.WriteString("FDP")
                                net.WriteString(LocalPlayer().Characters["FDP"].sid)
                                net.SendToServer()
                                OAWC.Charactersystem.UI.Menu:Remove()
                            elseif not LocalPlayer().Characters["FDP"] and v.kind == "FDP" then
                                CreateCharacter("FDP")
                            end
                        end
                    end
                end

            end
        end)
    end
    task()
end


concommand.Add("oawc_charactersystem_mainmenu", function()
    OAWC.Charactersystem.UI:MainMenu()
end)