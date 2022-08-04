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




surface.CreateFont("AmmoFont", {
    font = "Digital-7",
	size = 23,
	weight = 1000,
	antialias = true,
	shadow = true,
})


OAWC:RegisterFont("OAWC.HUD.Compass.Tri", {font = "Lato", size = ScrH() * 0.009, weight = 600, shadow = true, extended = true});


OAWC:RegisterFont("OAWC.HUD.Compass.BigLetters", {font = "Lato", size = ScrH() * 0.018, weight = 600, shadow = true, extended = true});

OAWC:RegisterFont("OAWC.HUD.Compass.SmallLetters", {font = "Montserrat", size = ScrH() * 0.011, weight = 400, shadow = true, extended = true} )

OAWC:RegisterFont("OAWC.HUD.Compass.SmallNumbers", {font = "Montserrat", size = ScrH() * 0.011  , weight = 400, shadow = true, extended = true} )










local SpawnI

hook.Remove("HUDPaint", "HealthAndArmorPaint")
hook.Add("HUDPaint", "OAWC.HUDPaintMAIN", function()
    

    
    local scrW, scrH = ScrW(), ScrH()
    local boxW = scrW * 0.12
    local boxH = scrH * 0.007

    local ply = LocalPlayer()
    local hp = ply:Health()
    local maxHp = ply:GetMaxHealth()
    local armor = ply:Armor()
    local maxArmor = ply:GetMaxArmor()

    local weapon = ply:GetActiveWeapon()

    local vignette = Material("materials/oawc/hud/vignette.png")
    local TarkovStand = Material("materials/oawc/hud/tarkovstand.png")
    local TarkovSit = Material("materials/oawc/hud/tarkovsit.png")
    local TarkovLean = Material("materials/oawc/hud/tarkovlean.png")

    function drawVignette()
        surface.SetMaterial(vignette)
        surface.SetDrawColor(255, 255, 255, 205)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    end

    function drawVignetteOnBars(x, y, wide, height)
        surface.SetMaterial(vignette)
        surface.SetDrawColor(255, 255, 255, 215)
        surface.DrawTexturedRect(x, y, wide, height)
    end

    function drawTriangle(trianglePos)
        surface.SetDrawColor(240, 240, 240, 225)
        draw.NoTexture()
        surface.DrawPoly(trianglePos)
    end

    function drawWhiteRects(y)
        surface.SetDrawColor(255, 255, 255, 160)

        for i = 1, 7 do
            surface.DrawRect(30, y, boxH * 0.62, boxH * 0.62)
            if (i == 6) then
                y = y + 64
            else
                y = y + 30
            end
        end

    end

    triangleStand = {
        {x = 17, y = scrH * .745},
	    {x = 17, y = scrH * .74},
	    {x = 22, y = scrH * .742}
    }

    triangleSit = {
        {x = 17, y = scrH * .745 + 5 * 30},
        {x = 17, y = scrH * .74 + 5 * 30},
        {x = 22, y = scrH * .742 + 5 * 30}
    }

    triangleLean = {
        {x = 17, y = scrH * .745 + scrH * .198},
        {x = 17, y = scrH * .74 + scrH * .198},
        {x = 22, y = scrH * .742 + scrH * .198}
    }

    if (ply:Alive()) then
        if LocalPlayer():InVehicle() then return end;
        if (weapon:IsValid()) then
        --    if (weapon:Clip1() != -1) then
          --      draw.WordBox(2, scrW * .15, scrH * .95, weapon:Clip1() .. "/" .. ply:GetAmmoCount(weapon:GetPrimaryAmmoType()), "AmmoFont", Color(0, 0, 0, 120), Color(255, 255, 255, 120), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        --    else
          --      draw.WordBox(2, scrW * .15, scrH * .95, ply:GetAmmoCount(weapon:GetPrimaryAmmoType()), "AmmoFont", Color(0, 0, 0, 120), Color(255, 255, 255, 120), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
       --     end

           -- if (ply:GetAmmoCount(weapon:GetSecondaryAmmoType()) > 0) then
          --      draw.WordBox(2, scrW * .19, scrH * .95, ply:GetAmmoCount(weapon:GetSecondaryAmmoType()), "AmmoFont", Color(0, 0, 0, 120), Color(222, 31, 31, 120), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
         --   end
        end

        surface.SetDrawColor(48, 48, 48, 255)
        surface.DrawRect(51, scrH * .95, boxW + 4, boxH + 4)
        surface.SetDrawColor(0, 0, 0, 160)
        surface.DrawRect(53, scrH * .952, boxW, boxH)

      --  surface.SetDrawColor(48, 48, 48, 255)
      --  surface.DrawRect(51, scrH * .965, boxW + 4, boxH + 4)
     --   surface.SetDrawColor(0, 0, 0, 160)
      --  surface.DrawRect(53, scrH * .967, boxW, boxH)

        surface.SetDrawColor(0, 0, 0, 220)
        surface.DrawRect(29, scrH * .742 - 1, boxH * 0.62 + 2, boxW * .95 + 2)
        surface.SetDrawColor(94, 94, 94, 140)
        surface.DrawRect(30, scrH * .742, boxH * 0.62, boxW * .95)
/*

        if (hp >= maxHp) then
            surface.SetDrawColor(68, 160, 235, 255)
            surface.DrawRect(53, scrH * .952, boxW, boxH)
        else
            surface.SetDrawColor(68, 160, 235, 255)
            surface.DrawRect(53, scrH * .952, boxW * (hp / maxHp), boxH)
        end
*/

/*


        if (armor >= maxArmor) then
            surface.SetDrawColor(63, 217, 132, 255)
            surface.DrawRect(53, scrH * .967, boxW, boxH)
        else
            surface.SetDrawColor(63, 217, 132, 255)
            surface.DrawRect(53, scrH * .967, boxW * (armor / maxArmor), boxH)
        end
*/
        drawVignetteOnBars(53, scrH * .952, boxW, boxH)
       -- drawVignetteOnBars(53, scrH * .967, boxW, boxH)
        drawWhiteRects(scrH * .74)

        if (ply:Crouching() and !ply:IsProne()) then
            surface.SetDrawColor(255, 255, 255, 220)
            surface.SetMaterial(TarkovSit)
            surface.DrawTexturedRect(55, scrH * .712, scrW * .105, scrH * .236)
            drawTriangle(triangleSit)
        elseif (ply:IsProne()) then
            surface.SetDrawColor(255, 255, 255, 220)
            surface.SetMaterial(TarkovLean)
            surface.DrawTexturedRect(55, scrH * .712, scrW * .166, scrH * .237)
            drawTriangle(triangleLean)
        else
            surface.SetDrawColor(255, 255, 255, 220)
            surface.SetMaterial(TarkovStand)
            surface.DrawTexturedRect(55, scrH * .712, scrW * .105, scrH * .236)
            drawTriangle(triangleStand)
        end


            local dir = EyeAngles().y
    
            for i = 0, 360 / 15 - 1 do
                local ang = i * 15
                local dif = math.AngleDifference(ang, dir)
                local offang = (18 * 10) / 2.8
    
                if math.abs(dif) < offang then
                    local dif2 = ScrW() * 0.014
                    local pos = dif / 15 * dif2
                    local text = tostring(360 - ang) .. "°"
                    local font = "OAWC.HUD.Compass.SmallNumbers"
                    local clr = Color(61,61,61)
                    local white = Color(255,255,255)
    
                    if ang == 0 then
                        text = "N"
                        font = "OAWC.HUD.Compass.BigLetters"
                        clr = white
                    elseif ang == 180 then
                        text = "S"
                        font = "OAWC.HUD.Compass.BigLetters"
                        clr = white
                    elseif ang == 90 then
                        text = "W"
                        font = "OAWC.HUD.Compass.BigLetters"
                        clr = white
                    elseif ang == 270 then
                        text = "O"
                        font = "OAWC.HUD.Compass.BigLetters"
                        clr = white
                    elseif ang == 45 then
                        text = "NW"
                        font = "OAWC.HUD.Compass.SmallLetters"
                        clr = white
                    elseif ang == 135 then
                        text = "SW"
                        font = "OAWC.HUD.Compass.SmallLetters"
                        clr = white
                    elseif ang == 225 then
                        text = "SO"
                        font = "OAWC.HUD.Compass.SmallLetters"
                        clr = white
                    elseif ang == 315 then
                        text = "NE"
                        font = "OAWC.HUD.Compass.SmallLetters"
                        clr = white
                    end
    
                    draw.DrawText("╿\n" .. text, font, scrW / 2 - pos - scrW * 0.415, scrH * 0.96, clr, TEXT_ALIGN_CENTER)
                end
    
                local text = "0"
                dir = math.Round(dir, 0)
    
                if (dir >= 0) then
                    local cust = dir - 180
                    cust = 360 - dir
                    text = tostring(cust)
                else
                    local cust = dir + 180
                    cust = dir * -1
                    text = tostring(cust) + 1
                end
    
                draw.SimpleText(text, "OAWC.HUD.Compass.SmallLetters", scrW / 2, scrH * 0.05, Color(250,255,255), TEXT_ALIGN_CENTER)
                draw.DrawText("▼", "OAWC.HUD.Compass.Tri", scrW * 0.086, scrH * 0.96, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
            end


        local health = LocalPlayer():Health()
        if health < 0 then health = 0 elseif health > 100 then health = 100 end
            health = health / 5
        
        local HealthW = 53
        for k=0, health do
            if k < health then 
                surface.SetDrawColor(255,255,255,255)
                surface.SetMaterial(Material("oawc/hud/bulletbar.jpg"))
                surface.DrawTexturedRect( HealthW, ScrH()- 52, 11, boxH )
                HealthW = HealthW + 11.6*1
            end
        end
    end
end)