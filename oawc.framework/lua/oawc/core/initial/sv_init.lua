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
util.AddNetworkString("OAWC.SetDoNothing")

local PLAYER = FindMetaTable("Player")

function PLAYER:SetSpectatorMode(bool)
  net.Start("OAWC.SetDoNothing")
  net.WriteBool(bool)
  net.Send(self)
  if bool then
      for k, v in pairs(self:GetWeapons()) do
          self:StripWeapon(v:GetClass())
      end
      self:SetTeam(TEAM_SPECTATOR)
      self.DoNothing = true
      self:GodEnable()
      self:SetMoveType(MOVETYPE_NOCLIP)
      self:SetCollisionGroup(COLLISION_GROUP_WORLD)
      self:SetNoTarget(true)
      self:SetNotSolid(true) 
      self:SetNoDraw(true)
      self:SetNoCollideWithTeammates(true)
      self:SetCustomCollisionCheck(true)
  else
      self.DoNothing = false
      self:GodDisable()
      self:SetMoveType(MOVETYPE_WALK)
      self:SetCollisionGroup(COLLISION_GROUP_PLAYER)
      self:SetNoTarget(false)
      self:SetNotSolid(false)
      self:SetNoDraw(false)
      self:SetNoCollideWithTeammates(false)
      self:SetCustomCollisionCheck(false)
  end
end


 

hook.Add("PlayerSpawn", "CheckInitplayer", function(ply)
  if ply.CharacterID == nil or ply.CharacterID == 0 then 
      ply.CharacterID = 0
      timer.Simple(0.1, function()
        ply:SetSpectatorMode(true)
        net.Start("OAWC.CharSys.UpdateNumberInformation")
        net.WriteInt(0, 32)
        net.Send(ply)
      end)
  end
  --print(ply.CharacterID)
end) 

