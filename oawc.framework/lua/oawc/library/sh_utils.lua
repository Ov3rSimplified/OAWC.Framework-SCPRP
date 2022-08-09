--[[
 _______  _______           _______      _______  _______  _______  _______  _______           _______  _______  _
(  ___  )(  ___  )|\     /|(  ____ \    (  ____ \(  ____ )(  ___  )(       )(  ____ \|\     /|(  ___  )(  ____ )| \    /\
| (   ) || (   ) || )   ( || (    \/    | (    \/| (    )|| (   ) || () () || (    \/| )   ( || (   ) || (    )||  \  / /
| |   | || (___) || | _ | || |          | (__    | (____)|| (___) || || || || (__    | | _ | || |   | || (____)||  (_/ /
| |   | ||  ___  || |( )| || |          |  __)   |     __)|  ___  || |(_)| ||  __)   | |( )| || |   | ||     __)|   _ (
| |   | || (   ) || || || || |          | (      | (\ (   | (   ) || |   | || (      | || || || |   | || (\ (   |  ( \ \
| (___) || )   ( || () () || (____/\    | )      | ) \ \__| )   ( || )   ( || (____/\| () () || (___) || ) \ \__|  /  \ \
(_______)|/     \|(_______)(_______/    |/       |/   \__/|/     \||/     \|(_______/(_______)(_______)|/   \__/|_/    \/


// Informations!
// Author: TwinKlee
// Startday: 27.06.2022 / 14:23
// FRAMEWORK FOR THE OAWC SCPRP !!
// YOUR NOT ALLOWED TO EDIT OR LEAK OR REUPLOAD THIS WITHOUT MY RELEASE !!
]]

local blur = Material("pp/blurscreen")

function OAWC.L:DrawBlurRect(x, y, w, h, amount, density)
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)

    for i = 1, density do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        render.SetScissorRect(x, y, x + w, y + h, true)
        surface.DrawTexturedRect(0 * -1, 0 * -1, ScrW(), ScrH())
        render.SetScissorRect(0, 0, 0, 0, false)
    end
end

// FINDPLAYER function
// @param info - The Player did you search for

function OAWC.FindPlayer(info)
    if not info or info == "" then return nil end
    local pls = player.GetAll()

    for k = 1, #pls do -- Proven to be faster than pairs loop.
        local v = pls[k]
        if tonumber(info) == v:UserID() then
            return v
        end

        if info == v:SteamID() then
            return v
        end

        if string.find(string.lower(v:Nick()), string.lower(tostring(info)), 1, true) ~= nil then
            return v
        end

        if string.find(string.lower(v:SteamName()), string.lower(tostring(info)), 1, true) ~= nil then
            return v
        end
    end
    return nil
end

function OAWC:RegisterFont(name,tbl)
    surface.CreateFont( name, tbl)
end

function net.WriteCompressedTable(tbl)
    local data = util.TableToJSON(tbl)
    data = util.Compress(data)
    net.WriteInt(#data, 32)
    net.WriteData(data, #data)
end

function net.ReadCompressedTable()
    local num = net.ReadInt(32)
    local data = util.Decompress(net.ReadData(num))
    return util.JSONToTable(data)
end

OAWC.L.scrollingtext_store = {}
OAWC.L.particles_store = {}
function OAWC.L:SimpleScrollingText(scrollid, text, font, x, y, color, ax, ay)
    ax = ax or 0
    ay = ay or 0
    if (!scrollid) then
        scrollid = table.insert(OAWC.L.scrollingtext_store, {
            ["text"] = "",
            ["count"] = 0,
            ["next"] = SysTime()
        })
        return scrollid
    end
    if (!OAWC.L.scrollingtext_store[scrollid]) then return end
    local nowText = OAWC.L.scrollingtext_store[scrollid]["text"]

    surface.SetFont(font)
    local width, height = surface.GetTextSize(nowText)
    draw.SimpleText(nowText, font, x, y, color, ax, ay)

    if (OAWC.L.scrollingtext_store[scrollid].next <= SysTime() and OAWC.L.scrollingtext_store[scrollid]["count"] < string.len(text)+1) then
        OAWC.L.scrollingtext_store[scrollid].next = SysTime() + 0.05
        OAWC.L.scrollingtext_store[scrollid]["text"] = OAWC.L.scrollingtext_store[scrollid]["text"] .. string.sub(text, OAWC.L.scrollingtext_store[scrollid]["count"], OAWC.L.scrollingtext_store[scrollid]["count"])
        OAWC.L.scrollingtext_store[scrollid]["count"] = OAWC.L.scrollingtext_store[scrollid]["count"] + 1
        surface.PlaySound("items/nvg_off.wav")
    end;

    if (OAWC.L.scrollingtext_store[scrollid]["count"] >= string.len(text)) then
        OAWC.L.scrollingtext_store[scrollid] = nil
        return -1
    end

    return scrollid
end

function OAWC.L:CreateTextField(parent)
    local panel = vgui.Create("DTextEntry", parent)
    panel.Paint = function(self, w, h)
        self.alpha = self.alpha or 0
        self.alpha2 = self.alpha2 or 0
        self.Rounded = self.Rounded or 0
        if (self.hovered) then
            self.alpha = Lerp(FrameTime()*3, self.alpha, 1)
        else
            self.alpha = Lerp(FrameTime()*6, self.alpha, 0)
        end
        if (self:IsEditing()) then
            self.alpha2 = Lerp(FrameTime()*3, self.alpha2, 1)
        else
            self.alpha2 = Lerp(FrameTime()*6, self.alpha2, 0)
        end

        draw.RoundedBox(self.Rounded, 0, 0, w, h, Color(0, 0, 0, 150))
        draw.RoundedBox(self.Rounded, 0, 0, w, h, Color(255, 255, 255, 35*self.alpha))
        if self.SetColor == nil then
            draw.RoundedBox(self.Rounded, 0, 0, w, h, Color(255, 209, 55, 75*self.alpha2))
        else
            draw.RoundedBox(self.Rounded, 0, 0, w, h, Color(self.SetColor.r, self.SetColor.g, self.SetColor.b, 75*self.alpha2))
        end
        if (self:GetText() == "") then
            draw.SimpleText(self:GetPlaceholderText(), "OAWC.CHS.Test", 5, h/2, Color(255, 255, 255, 100), 0, 1)
        end
        draw.SimpleText(self:GetText(), "OAWC.CHS.Test", 5, h/2, Color(255, 255, 255, 255), 0, 1)
    end
    panel.OnCursorEntered = function(self)
        self.hovered = true
        surface.PlaySound("physics/metal/metal_popcan_impact_hard1.wav")
    end
    panel.OnMousePressed1 = panel.OnMousePressed
    panel.OnMousePressed = function(self)
        surface.PlaySound("items/nvg_off.wav")
        if (self.disabled) then return false; end
        panel.OnMousePressed1(self)
    end
    panel.OnCursorExited = function(self)
        self.hovered = false
    end
    return panel
end


if CLIENT then
    OAWC:RegisterFont("OAWC.Notifyer.Top", {
        font = "Bauhaus Md BT",
        size = ScrH() * 0.04,
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
    OAWC:RegisterFont("OAWC.Notifyer.Content", {
        font = "Montserrat",
        size = ScrH() * 0.025,
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
    function OAWC:Notify(mode, title, body, duration)
        mode = mode or "info"
        title = title or ""
        body = body or ""
        duration = duration or 4


        --  surface.PlaySound("rdsrp/ui/notify.wav")

        if IsValid(self.Current) then
            self.Current:Remove()
        end

        self.Current = vgui.Create("DPanel")
        self.Current:SetPos(ScrW() * 0.74, ScrH() * 0.1)
        self.Current:SetSize(ScrW() * 0.25, ScrH() * 0.14)
        self.Current:SetDrawOnTop(true)
        self.Current:SetAlpha(0)

        -- Need to set this outside the paint func to use it in the rich text.
        if mode == "success" then
            self.Current.headlineColor = Color(0,255,34)
            self.Current.titleColor = Color(0,255,34)
            self.Current.textColor = Color(255,255,255)
        elseif mode == "error" then
            self.Current.headlineColor = Color(255,0,0)
            self.Current.titleColor = Color(255,0,0)
            self.Current.textColor = Color(255,255,255)
        elseif mode == "warning" then
            self.Current.headlineColor = Color(255,187,0)
            self.Current.titleColor = Color(255,187,0)
            self.Current.textColor = Color(255,255,255)
        elseif mode == "info" then
            self.Current.headlineColor = Color(0,150,250)
            self.Current.titleColor = Color(0,150,250)
            self.Current.textColor = Color(255,255,255)
        end

            function self.Current:Paint(width, height)
                if vgui.GetKeyboardFocus() then
                    draw.RoundedBox(5,0,0,width,height,Color(46,46,46)) --255,193,7,255
                    draw.RoundedBox(5, 2, 2, width - 4, height -4, Color(23,22,22))
                else
                    draw.RoundedBox(5,0,0,width,height,Color(46,46,46)) --255,193,7,255
                    draw.RoundedBox(5, 2, 2, width - 4, height -4, Color(23,22,22))
                end
                draw.RoundedBox(0, 0, ScrH() * 0.040, width, height * 0.05, self.headlineColor)
            end

            local w, h = self.Current:GetWide(), self.Current:GetTall()


        local top = vgui.Create("DLabel", self.Current)
        top:Dock(TOP)
        top:SetTall(ScrH() * 0.040)
        top:SetText("")
            top.Paint = function(self,w,h)
                if vgui.GetKeyboardFocus() then
                    draw.RoundedBoxEx(9, 0, 0, w, h, Color(46,46,46),true,true,false,false)
                else
                    draw.RoundedBoxEx(9, 0, 0, w, h, Color(46,46,46),true,true,false,false)
                end

                draw.DrawText(title, "OAWC.Notifyer.Top", self:GetWide() / 2, 1, self.titleColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

        local bodyText = vgui.Create("RichText", self.Current)
        bodyText:Dock(FILL)
        bodyText:DockMargin(w * 0.01, h * 0.15, w * 0.01, h * 0.05)
        bodyText:AppendText(body)
        bodyText:SetVerticalScrollbarEnabled(false)
            function bodyText:PerformLayout()
                self:SetFontInternal("OAWC.Notifyer.Content")
            end

            self.Current:AlphaTo(255, 0.75, 0)
            self.Current:AlphaTo(0, 0.75, duration + 0.75, function()
                if IsValid(self.Current) then
                    self.Current:Remove()
                end
            end)

    end

    net.Receive("OAWC.Notifyer", function()
        local mode = net.ReadString()
        local title = net.ReadString()
        local body = net.ReadString()
        local duration = net.ReadInt(8)
        OAWC:Notify(mode, title, body, duration)
    end)

end

if SERVER then
    util.AddNetworkString("OAWC.Notifyer")

    function OAWC:Notify(mode, ply, title, body, duration)

        net.Start("OAWC.Notifyer")
            net.WriteString(mode)
            net.WriteString(title)
            net.WriteString(body)
            net.WriteInt(duration, 8)
        net.Send(ply)
    end
end




function OAWC.ConfigTableAvailable()
    if table.IsEmpty(OAWC.CoreConfig) then
        return false
    else
        return true
    end
end

--[[
    PLYAYER FUNCTIONS
]]

local PLAYER = FindMetaTable("Player")

function PLAYER:GetCharacterKind()
    return self.CharacterKind or "N/A"
end
function PLAYER:GetCharacterID()
    return self.CharacterID or -1
end