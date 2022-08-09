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


hook.Add("OnPlayerChangedTeam", "OAWC.UdateTeamHook", function(ply,b,a)
   if ply.CharacterKind == "FDP" then
      if OAWC.Config.RegisteredJobs["FDP"][a] then
         OAWC.SQL:Query("UPDATE `OAWC_Character` SET lastjob = " .. SQLStr(a) .. " WHERE ID = " .. ply.CharacterID, nil,  OAWC.SQL.Error)
      end
   end
end)

hook.Add("playerCanChangeTeam", "OAWC.PlayerCanChangeTeamHook", function(ply, job_index, force)
   if ply.CharacterKind == "FDP" then
      if not OAWC.Config.RegisteredJobs["FDP"][job_index] then
         OAWC:Notify("error", ply, "Fehler!", "Du kannst diesen Job nicht als 'FDP' auswählen", 1.4)
         return false
      end
   end
   if ply.CharacterKind == "DCP" then
      if not OAWC.Config.RegisteredJobs["DCP"][job_index] then
         OAWC:Notify("error", ply, "Fehler!", "Du kannst diesen Job nicht als 'DCP' auswählen", 1.4)
         return false
      end
   end
   if ply.CharacterKind == "SCP" then
      if not OAWC.Config.RegisteredJobs["SCP"][job_index] then
         OAWC:Notify("error", ply, "Fehler!", "Du kannst diesen Job nicht als 'SCP' auswählen", 1.4)
         return false
      end
   end
end)

