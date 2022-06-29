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


net.Receive("OAWC.SetDoNothing", function()
    LocalPlayer().DoNothing = net.ReadBool()
end)

local hide = {
    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudAmmo"] = true,
    ["CHudEnergy"] = true,
    ["DarkRP_HUD"] = true,
    ["CHudSecondaryAmmo"] = true,
    ["DarkRP_EntityDisplay"] = true
}

hook.Add("HUDShouldDraw", "RDSRP.HideHud", function(name)
    if (hide[name]) then return false end
end)


local scplogo = Material("materials/oawc/logos/scplogo2.png")
hook.Add("HUDPaint", "DoNothingHud", function()
  /*  if LocalPlayer().DoNothing then 
        draw.RoundedBox(0,0,0,ScrW(),ScrH(),Color(57,57,57,230))
        DrawBlurRect(0,0,ScrW(),ScrH(), 3, 6)

        surface.SetDrawColor(Color(255,255,255))
        surface.SetMaterial(scplogo)
        surface.DrawTexturedRect(-30,ScrH()*0.01,ScrW()*0.15,ScrH()*0.15)

        draw.RoundedBox()
    end*/
end)