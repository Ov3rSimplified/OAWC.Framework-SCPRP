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

hook.Add("HUDShouldDraw", "OAWC.Scroll.Disable", function(name)
    if name == "CHudWeaponSelection" then
      if LocalPlayer().CharacterKind == "DRP" or LocalPlayer().CharacterKind == "FDP" then
          return false;
      else
          return true;
      end
    end
end);

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
OAWC:RegisterFont("OAWC.WPS.FontGrand", { 
	font = "Bauhaus Md BT", 
	size = ScrH() * 0.035,
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
OAWC:RegisterFont("OAWC.WPS.FontSmall", { 
	font = "Bauhaus Md BT", 
	size = ScrH() * 0.01,
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
OAWC:RegisterFont("OAWC.WPS.weapon", { 
	font = "Bauhaus Md BT", 
	size = ScrH() * 0.038,
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


local current = 1
local SlotE = {}
if LocalPlayer().CharacterKind == "DRP" or LocalPlayer().CharacterKind == "FDP" then  
  SlotE = {
    [-1] = tostring(OAWC.CoreConfig.HandSwep),
    [1] =  LocalPlayer().Characters[LocalPlayer().CharacterKind].inventory.Slot[1] or "NULL",
    [2] =  LocalPlayer().Characters[LocalPlayer().CharacterKind].inventory.Slot[2] or "NULL",
    [3] =  LocalPlayer().Characters[LocalPlayer().CharacterKind].inventory.Slot[3] or "NULL",
  }
end;


hook.Add("PlayerBindPress", "StarWarsHUD.WeaponSelector", function(ply, bind, pressed)
  ply = LocalPlayer();
  local wp = ply:GetWeapons();
  if not LocalPlayer().CharacterKind == "DRP" and LocalPlayer().CharacterKind == "FDP" then return end;
  
  if table.IsEmpty(SlotE) then return end
  if bind == "invnext" and not ply:KeyDown(IN_ATTACK) and pressed then
      if current == -1 then 
          current = 1;
          if ply:HasWeapon(SlotE[current]) then
              if ply:GetActiveWeapon():GetClass() == SlotE[current] then
              else
                  if SlotE[current] == "NULL" then return; end;
                  local s = ply:GetWeapon(SlotE[current]):GetClass();
                  RunConsoleCommand('use', s );
                  return true;
              end;
          end;
      else
          if current < 3 then
              current = current + 1;
              if ply:HasWeapon(SlotE[current]) then
                  if ply:GetActiveWeapon():GetClass() == SlotE[current] then
                  else
                      if SlotE[current] == "NULL" then return; end;
                      local s = ply:GetWeapon(SlotE[current]):GetClass();
                      RunConsoleCommand('use', s );
                      return true;
                  end;
              end;
          else
              current = 1;
              if ply:HasWeapon(SlotE[current]) then
                  if ply:GetActiveWeapon():GetClass() == SlotE[current] then
                  else
                      if SlotE[current] == "NULL" then return; end;
                      local s = ply:GetWeapon(SlotE[current]):GetClass();
                      RunConsoleCommand('use', s );
                      return true;
                  end;
              end;
          end;
      end;
  end;

  if bind == "invprev" and not ply:KeyDown(IN_ATTACK) and pressed then

      if current - 1 == 0 or current == -1 then
          current = 3;
          if ply:HasWeapon(SlotE[current]) then
              if ply:GetActiveWeapon():GetClass() == SlotE[current] then
              else
                  if SlotE[current] == "NULL" then return; end;
                  local s = ply:GetWeapon(SlotE[current]):GetClass();
                  RunConsoleCommand('use', s );
                  return true;
              end;
          end;
      else
          current = current - 1;
          if ply:HasWeapon(SlotE[current]) then
              if ply:GetActiveWeapon():GetClass() == SlotE[current] then
              else
                  if SlotE[current] == "NULL" then return; end;
                  local s = ply:GetWeapon(SlotE[current]):GetClass();
                  RunConsoleCommand('use', s );
                  return true;
              end;
          end;
      end;
  end;  

  if bind == "+attack" and not ply:KeyDown(IN_ATTACK) and pressed then
    if not LocalPlayer().CharacterKind == "DRP" and LocalPlayer().CharacterKind == "FDP" then return end;
      local wp = ply:GetWeapons()
      if ply:HasWeapon(SlotE[current]) then
        if ply:GetActiveWeapon():GetClass() == "gmod_tool" or ply:GetActiveWeapon():GetClass() == "weapon_physgun" then return end
          if ply:GetActiveWeapon():GetClass() == SlotE[current] then
          else
              local s = ply:GetWeapon(SlotE[current]):GetClass()
              RunConsoleCommand('use', s )
              return true
          end
      end
  end

end)

concommand.Add("switch_", function(ply,cmd,args,argstr)
  if not LocalPlayer().CharacterKind == "DRP" and LocalPlayer().CharacterKind == "FDP" then return end;
  ply = LocalPlayer();
  local wp = ply:GetWeapons();

  if tonumber(args[1]) == nil then 
      return;
  else
      current = tonumber(args[1]);
      if ply:HasWeapon(SlotE[current]) then
          if ply:GetActiveWeapon():GetClass() == SlotE[current] then
          else
              if SlotE[current] == "NULL" then return; end;
              local s = ply:GetWeapon(SlotE[current]):GetClass();
              RunConsoleCommand('use', s );
              return true;
          end;
      end;
  end;
end)

local delay = 0
hook.Add( "PlayerButtonDown", "OAWC.WPS", function( ply, button )
  if not LocalPlayer().CharacterKind == "DRP" and LocalPlayer().CharacterKind == "FDP" then return end;
    ply = LocalPlayer();
    if delay < CurTime() then 
        if button == KEY_G then
            current = -1;
            if ply:HasWeapon(SlotE[current]) then
                if ply:GetActiveWeapon():GetClass() == SlotE[current] then
                else
                    if SlotE[current] == "NULL" then return; end;
                    local s = ply:GetWeapon(SlotE[current]):GetClass();
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


local Color = Color
local white = Color(255,255,255,255)
local prettywhite = Color(217, 215, 214, 255)
local black = Color(0,0,0,255)
local blackalpha = Color(0,0,0,70)

hook.Add("HUDPaint", "OAWC.HUDPaint.Scroll", function()

 if not LocalPlayer():Alive() then return end;
 if LocalPlayer():InVehicle() then return end;
 if LocalPlayer().CharacterKind == "SCP" then return end;

    local hand;
    local prim;
    local sec;
    local side;

    if SlotE[-1] == "NULL" then
      hand = "LEER";
    else
      if weapons.Get(SlotE[-1]) then
        if LocalPlayer():HasWeapon(SlotE[-1]) then
          hand = tostring(LocalPlayer():GetWeapon(SlotE[-1]):GetPrintName());
        else
          hand = "LEER";
        end;
      end;
    end;
    if SlotE[1] == "NULL" then
      prim = "LEER";
    else
      if weapons.Get(SlotE[1]) then
        if LocalPlayer():HasWeapon(SlotE[1]) then
          prim = tostring(LocalPlayer():GetWeapon(SlotE[1]):GetPrintName());
        else
          prim = "LEER";
        end;
      end;
    end; 
    if SlotE[2] == "NULL" then
      sec = "LEER";
    else
      if weapons.Get(SlotE[2]) then
        if LocalPlayer():HasWeapon(SlotE[2]) then
          sec = tostring(LocalPlayer():GetWeapon(SlotE[2]):GetPrintName());
        else
          sec = "LEER";
        end;
      end;
    end;
    if SlotE[3] == "NULL" then
      side = "LEER";
    else
      if weapons.Get(SlotE[3]) then
        if LocalPlayer():HasWeapon(SlotE[3]) then
          side = tostring(LocalPlayer():GetWeapon(SlotE[3]):GetPrintName());
        else
          side = "LEER";
        end;
      end; 
    end;

    OAWC.L:DrawBlurRect(ScrW() * 0.88, ScrH() * 0.737, ScrW() * 0.115, ScrH() * 0.05, 2, 6);
    draw.RoundedBox(0, ScrW() * 0.88, ScrH() * 0.737, ScrW() * 0.115, ScrH() * 0.05, current == -1 and prettywhite or blackalpha ); // 0
    draw.SimpleText(hand, "OAWC.WPS.FontBig", ScrW() * 0.88 + ScrW() * 0.115 / 2, ScrH() * 0.737 + ScrH() * 0.05 / 2, current == -1 and black or white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);     
    draw.SimpleText("[G]", "OAWC.WPS.FontBig", ScrW() * 0.92 + ScrW() * 0.115 / 2, ScrH() * 0.737 + ScrH() * 0.05 / 2, current == -1 and black or white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);     

    OAWC.L:DrawBlurRect(ScrW() * 0.88, ScrH() * 0.792, ScrW() * 0.115, ScrH() * 0.05, 2, 6);
    draw.RoundedBox(0, ScrW() * 0.88, ScrH() * 0.792, ScrW() * 0.115, ScrH() * 0.05, current == 1 and prettywhite or blackalpha); // 1
    draw.SimpleText(prim, "OAWC.WPS.FontBig", ScrW() * 0.88 + ScrW() * 0.115 / 2, ScrH() * 0.792 + ScrH() * 0.05 / 2, current == 1 and black or white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
    draw.SimpleText("[1]", "OAWC.WPS.FontBig", ScrW() * 0.92 + ScrW() * 0.115 / 2, ScrH() * 0.792 + ScrH() * 0.05 / 2, current == 1 and black or white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

    OAWC.L:DrawBlurRect(ScrW() * 0.88, ScrH() * 0.8471, ScrW() * 0.115, ScrH() * 0.05, 2, 6);
    draw.RoundedBox(0, ScrW() * 0.88, ScrH() * 0.8471, ScrW() * 0.115, ScrH() * 0.05, current == 2 and prettywhite or blackalpha); // 2
    draw.SimpleText(sec, "OAWC.WPS.FontBig", ScrW() * 0.88 + ScrW() * 0.115 / 2, ScrH() * 0.8471 + ScrH() * 0.05 / 2, current == 2 and black or white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
    draw.SimpleText("[2]", "OAWC.WPS.FontBig", ScrW() * 0.92 + ScrW() * 0.115 / 2, ScrH() * 0.8471 + ScrH() * 0.05 / 2, current == 2 and black or white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

    OAWC.L:DrawBlurRect(ScrW() * 0.88, ScrH() * 0.9, ScrW() * 0.115, ScrH() * 0.05, 2, 6);
    draw.RoundedBox(0, ScrW() * 0.88, ScrH() * 0.9, ScrW() * 0.115, ScrH() * 0.05, current == 3 and prettywhite or blackalpha); // 3
    draw.SimpleText(side, "OAWC.WPS.FontBig", ScrW() * 0.88 + ScrW() * 0.115 / 2, ScrH() * 0.9 + ScrH() * 0.05 / 2, current == 3 and black or white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
    draw.SimpleText("[3]", "OAWC.WPS.FontBig", ScrW() * 0.92 + ScrW() * 0.115 / 2, ScrH() * 0.9 + ScrH() * 0.05 / 2, current == 3 and black or white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

 
 
  if (LocalPlayer():GetActiveWeapon():IsValid()) then
        if (LocalPlayer():GetActiveWeapon():Clip1() != -1) then
          draw.SimpleText(LocalPlayer():GetActiveWeapon():Clip1() .. "/" .. LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "OAWC.WPS.FontGrand", ScrW() * 0.91, ScrH() * 0.87 + ScrH() * 0.20 / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
        else
           draw.SimpleText("", "OAWC.WPS.FontGrand", ScrW() * 0.9, ScrH() * 0.87 + ScrH() * 0.19 / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
        end
    end

end)

