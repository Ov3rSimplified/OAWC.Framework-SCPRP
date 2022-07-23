--
hook.Add("HUDShouldDraw", "StarWarsHUD.HideWeaponSelector", function(name)
    if name == "CHudWeaponSelection" then
        return true 
    end
end) 
print("StarWarsHUD: Weapon Selector Hidden")


local stadardweapon = "weapon_fists"
local tl = {
    [-3] = "weapon_fists",
    [1] = "tfa_ins2_sai_gry",
    [2] = "tfa_mwr_mp5",
    [3] = "tfa_ins2_usp_match",
}
local current = 1

hook.Add("PlayerBindPress", "StarWarsHUD.WeaponSelector", function(ply, bind, pressed)
    /*
    ply = LocalPlayer();
    local wp = ply:GetWeapons();

    if table.IsEmpty(tl) then return end
    if bind == "invnext" and not ply:KeyDown(IN_ATTACK) and pressed then
        if current == -3 then 
            current = 1;
            if ply:HasWeapon(tl[current]) then
                if ply:GetActiveWeapon():GetClass() == tl[current] then
                else
                    local s = ply:GetWeapon(tl[current]):GetClass();
                    RunConsoleCommand('use', s );
                    return true;
                end;
            end;
        else
            if current < 3 then
                current = current + 1;
                ply:ChatPrint("Num:" .. current);
                if ply:HasWeapon(tl[current]) then
                    if ply:GetActiveWeapon():GetClass() == tl[current] then
                    else
                        local s = ply:GetWeapon(tl[current]):GetClass();
                        RunConsoleCommand('use', s );
                        return true;
                    end;
                end;
            else
                current = 1;
                ply:ChatPrint("Num:"  .. current);
                if ply:HasWeapon(tl[current]) then
                    if ply:GetActiveWeapon():GetClass() == tl[current] then
                    else
                        local s = ply:GetWeapon(tl[current]):GetClass();
                        RunConsoleCommand('use', s );
                        return true;
                    end;
                end;
            end;
        end;
    end;

    if bind == "invprev" and not ply:KeyDown(IN_ATTACK) and pressed then

        if current - 1 == 0 or current == -3 then
            current = 3;
            ply:ChatPrint("Num:"  .. current);
            if ply:HasWeapon(tl[current]) then
                if ply:GetActiveWeapon():GetClass() == tl[current] then
                else
                    local s = ply:GetWeapon(tl[current]):GetClass();
                    RunConsoleCommand('use', s );
                    return true;
                end;
            end;
        else
            current = current - 1;
            ply:ChatPrint("Num:"  .. current);
            if ply:HasWeapon(tl[current]) then
                if ply:GetActiveWeapon():GetClass() == tl[current] then
                else
                    local s = ply:GetWeapon(tl[current]):GetClass();
                    RunConsoleCommand('use', s );
                    return true;
                end;
            end;
        end;
    end;  

    /*
    if bind == "+attack" and not ply:KeyDown(IN_ATTACK) and pressed then
        local wp = ply:GetWeapons()
        if ply:HasWeapon(tl[current]) then
            if ply:GetActiveWeapon():GetClass() == tl[current] then
            else
                local s = ply:GetWeapon(tl[current]):GetClass()
                RunConsoleCommand('use', s )
                return true
            end
        end
    end
    */
end)

concommand.Add("switch_", function(ply,cmd,args,argstr)
    ply = LocalPlayer();
    local wp = ply:GetWeapons();
    if tonumber(args[1]) == nil then 
        return;
    else
        current = tonumber(args[1]);
        if ply:HasWeapon(tl[current]) then
            if ply:GetActiveWeapon():GetClass() == tl[current] then
            else
                local s = ply:GetWeapon(tl[current]):GetClass();
                RunConsoleCommand('use', s );
                return true;
            end;
        end;
    end;
end)

local delay = 0
hook.Add( "PlayerButtonDown", "OAWC.WPS", function( ply, button )
    ply = LocalPlayer();
    if delay < CurTime() then 
        if button == KEY_G then
            current = -3;
            if ply:HasWeapon(tl[current]) then
                if ply:GetActiveWeapon():GetClass() == tl[current] then
                else
                    local s = ply:GetWeapon(tl[current]):GetClass();
                    RunConsoleCommand('use', s );
                    return true;
                end;
            end;
        end;
        if button == KEY_1 then
            ply:ConCommand("switch_ 1");
        elseif button == KEY_2 then
            ply:ConCommand("switch_ 2");
        elseif button == KEY_3 then
            ply:ConCommand("switch_ 3");
        end;


        delay = CurTime() + 0.2;
    end;
end)



OAWC:RegisterFont("OAWC.WPS.FontBig", { 
	font = "Bauhaus Md BT", 
	size = ScrH() * 0.03,
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
});

local speed = 0.2
local barStatus = 0  
hook.Add("HUDPaint", "StarWarsHUD.WeaponSelector", function()
    /*
    local ply = LocalPlayer();
    if ply:HasWeapon(tl[current]) then
        local s = ply:GetWeapon(tl[current]):GetClass();
        draw.SimpleText("Weapon: " .. ply:GetWeapon(tl[current]):GetPrintName(), "DermaLarge", ScrW() / 2, ScrH() * 0.6, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
    end;

    local cl0 = Color(0, 0, 0, 100);
    local cl1 = Color(0, 0, 0, 100);
    local cl2 = Color(0, 0, 0, 100);
    local cl3 = Color(0, 0, 0, 100);

    local txtc0 = Color(255, 255, 255, 255);
    local txtc1 = Color(255, 255, 255, 255);
    local txtc2 = Color(255, 255, 255, 255);
    local txtc3 = Color(255, 255, 255, 255);

    if current == 1 then
        cl1 = Color(217, 215, 214, 255);
        txtc1 = Color(0, 0, 0);
    elseif current == 2 then
        cl2 = Color(217, 215, 214, 255);
        txtc2 = Color(0, 0, 0);
    elseif current == 3 then
        cl3 = Color(217, 215, 214, 255);
        txtc3 = Color(0, 0, 0);
    elseif current == -3 then
        cl0 = Color(217, 215, 214, 255);
        txtc0 = Color(0, 0, 0);
    end;


    OAWC.L:DrawBlurRect(ScrW() * 0.8, ScrH() * 0.674, ScrW() * 0.145, ScrH() * 0.06, 2, 6);
    draw.RoundedBox(0, ScrW() * 0.8, ScrH() * 0.674, ScrW() * 0.145, ScrH() * 0.06, cl0); // 0
    draw.SimpleText(tostring(ply:GetWeapon(tl[-3]):GetPrintName()) .. " [G]" or "N/A" .. " [G]", "OAWC.WPS.FontBig", ScrW() * 0.8 + ScrW() * 0.145 / 2, ScrH() * 0.673 + ScrH() * 0.06 / 2, txtc0, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
    

    OAWC.L:DrawBlurRect(ScrW() * 0.8, ScrH() * 0.74, ScrW() * 0.145, ScrH() * 0.06, 2, 6);
    draw.RoundedBox(0, ScrW() * 0.8, ScrH() * 0.74, ScrW() * 0.145, ScrH() * 0.06, cl1); // 1
    draw.SimpleText(tostring(ply:GetWeapon(tl[1]):GetPrintName()) .. " [1]" or "N/A" .. " [1]", "OAWC.WPS.FontBig", ScrW() * 0.8 + ScrW() * 0.145 / 2, ScrH() * 0.74 + ScrH() * 0.06 / 2, txtc1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

    OAWC.L:DrawBlurRect(ScrW() * 0.8, ScrH() * 0.805, ScrW() * 0.145, ScrH() * 0.06, 2, 6);
    draw.RoundedBox(0, ScrW() * 0.8, ScrH() * 0.805, ScrW() * 0.145, ScrH() * 0.06, cl2); // 2
    draw.SimpleText(tostring(ply:GetWeapon(tl[2]):GetPrintName()) .. " [2]" or "N/A" .. " [2]", "OAWC.WPS.FontBig", ScrW() * 0.8 + ScrW() * 0.145 / 2, ScrH() * 0.805 + ScrH() * 0.06 / 2, txtc2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
    
    OAWC.L:DrawBlurRect(ScrW() * 0.8, ScrH() * 0.87, ScrW() * 0.145, ScrH() * 0.06, 2, 6);
    draw.RoundedBox(0, ScrW() * 0.8, ScrH() * 0.87, ScrW() * 0.145, ScrH() * 0.06, cl3); // 3
    draw.SimpleText(tostring(ply:GetWeapon(tl[3]):GetPrintName()) .. " [3]" or "N/A" .. " [3]", "OAWC.WPS.FontBig", ScrW() * 0.8 + ScrW() * 0.145 / 2, ScrH() * 0.87 + ScrH() * 0.06 / 2, txtc3, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

    


    draw.SimpleText( tl[1], "DermaLarge", ScrW() * 0.075, ScrH() * 0.79, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.RoundedBox(0, ScrW() * 0.0, ScrH() * 0.75, ScrW() * 0.004, ScrH() * 0.07, Color(255, 255, 255, 100))
    draw.SimpleText( tl[2], "DermaLarge", ScrW() * 0.075, ScrH() * 0.84, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.RoundedBox(0, ScrW() * 0.0, ScrH() * 0.825s, ScrW() * 0.004, ScrH() * 0.07, Color(255, 255, 255, 100))
    draw.SimpleText( tl[3], "DermaLarge", ScrW() * 0.075, ScrH() * 0.89, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
*/



end)
