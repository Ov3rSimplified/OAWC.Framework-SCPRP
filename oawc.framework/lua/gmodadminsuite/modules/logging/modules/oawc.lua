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


-- ## Select Character
local MODULE = bLogs:Module()

MODULE.Category = "OAWC Framework"
MODULE.Name = "Character Select"
MODULE.Colour = Color(126, 229, 42)
MODULE:Hook("OAWC.CharSys.SelectCharacter", "OAWC.CharSys.SelectCharacter", function(ply, id, kind)
    MODULE:Log(ply:Nick() .. " ➞ Selected Character[" .. tostring(id) .. "]")
end)

bLogs:AddModule(MODULE)


-- ## Create Character
local MODULE = bLogs:Module()

MODULE.Category = "OAWC Framework"
MODULE.Name = "Character Create"
MODULE.Colour = Color(126, 229, 42)
MODULE:Hook("OAWC.CharSys.CreateCharacter", "OAWC.CharSys.CreateCharacter", function(ply, name, kind)
    MODULE:Log(ply:Nick() .. " ➞ Created Character with name: " .. tostring(name) .. " in Category: " .. tostring(kind))
end)

bLogs:AddModule(MODULE)


-- ## Create Character
local MODULE = bLogs:Module()

MODULE.Category = "OAWC Framework"
MODULE.Name = "Character Delete"
MODULE.Colour = Color(236, 43, 17)
MODULE:Hook("OAWC.CharSys.DeleteCharacter", "OAWC.CharSys.DeleteCharacter", function( ply, id )
    MODULE:Log(ply:Nick() .. " ➞ Deleted Character with ID: " .. tostring(id) )
end)

bLogs:AddModule(MODULE)