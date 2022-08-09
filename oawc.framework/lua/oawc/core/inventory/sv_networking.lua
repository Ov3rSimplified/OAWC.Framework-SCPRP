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



hook.Add("PlayerCanPickupWeapon", "TEST", function(ply, wep)
   -- wep:Remove()
  ----  print("KOMSICH")
    --return true
end)

hook.Add("PlayerSpawn", "OAWC.GiveSlotWeapons", function(ply)
    if ply.Characters == nil or table.IsEmpty(ply.Characters) then return end
    if ply.CharacterKind == "SCP" then return end
    if ply.CharacterID == 0  or ply.CharacterID == nil then else
    ply:Give("weapon_ohands")
    for k,v in pairs(ply.Characters[ply.CharacterKind].inventory.Slot) do
        if v == "NULL" then continue end
            if weapons.Get(v) then
                ply:Give(v)
            end
        end
    end
end)
