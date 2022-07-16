--
hook.Add("HUDShouldDraw", "StarWarsHUD.HideWeaponSelector", function(name)
    if name == "CHudWeaponSelection" then
        return false
    end
end) 
print("StarWarsHUD: Weapon Selector Hidden")



local tl = {
    [1] = "weapon_ak472",
    [2] = "weapon_m42",
    [3] = "weapon_mac102",
}
local current = 1

hook.Add("PlayerBindPress", "StarWarsHUD.WeaponSelector", function(ply, bind, pressed)
    ply = LocalPlayer()
    
    if bind == "slot1" then 
        current = 1
        print("1")
    end

    if table.IsEmpty(tl) then return end
    if bind == "invnext" and not ply:KeyDown(IN_ATTACK) and pressed then
        if current < table.Count(tl) then
            current = current + 1
            ply:ChatPrint("Num:" .. current)
        else
            current = 1
            ply:ChatPrint("Num:"  .. current)
        end
    end

    if bind == "invprev" and not ply:KeyDown(IN_ATTACK) and pressed then

        if current - 1 == 0 then
            current = table.Count(tl)
            ply:ChatPrint("Num:"  .. current)
        else
            current = current - 1
            ply:ChatPrint("Num:"  .. current)
        end
    end  

    if bind == "+attack" and pressed then
        local wp = ply:GetWeapons()
        if ply:HasWeapon(tl[current]) then
       --     if not ply:GetWeapon(tl[current]) == tl[current] then
                local s = ply:GetWeapon(tl[current]):GetClass()
                RunConsoleCommand('use', s )
            --    return true
            end
       -- end
    end
end)


hook.Add("HUDPaint", "StarWarsHUD.WeaponSelector", function()
    local ply = LocalPlayer()
    if ply:HasWeapon(tl[current]) then
        local s = ply:GetWeapon(tl[current]):GetClass()
        draw.SimpleText("Weapon: " .. s, "DermaLarge", ScrW() / 2, ScrH() / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end 
end)

hook.Add( "PlayerButtonDown", "2", function( ply, button )
   -- if button == 112 then 
 --       LocalPlayer():ChatPrint("TAM")
  --  elseif button == 113 then 
   --     LocalPlayer():ChatPrint("TAM")
   -- end

end)


