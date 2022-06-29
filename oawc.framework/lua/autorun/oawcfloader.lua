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


MsgC(Color(38,255,0),[[______           ___         ____    __    ____      ______ ]],"\n")
MsgC(Color(38,255,0),[[/  __  \         /   \        \   \  /  \  /   /     /      |]],"\n")
MsgC(Color(38,255,0),[[|  |  |  |       /  ^  \        \   \/    \/   /     |  ,----']],"\n")
MsgC(Color(38,255,0),[[|  |  |  |      /  /_\  \        \            /      |  |     ]],"\n")
MsgC(Color(38,255,0),[[|  `--'  |     /  _____  \        \    /\    /       |  `----.]],"\n")
MsgC(Color(38,255,0),[[\______/     /__/     \__\        \__/  \__/         \______|]],"\n")                                                                                                                                 
                                                                                                                                                                                                                                                                                                  
OAWC = OAWC or {}
OAWC.Initialize = {}
OAWC.SQL = OAWC.SQL or {}
if SERVER then
    OAWC.SQL.MySQL = OAWC.SQL.MySQL or {}
end

function OAWC.Initialize:LoadDir(dir)
    local files = file.Find(dir.. "/".. "*", "LUA")

    for k, v in pairs(files) do
        if string.StartWith(v, "sh") then
            local load = include(dir.. "/".. v)
            if load then load() end

            AddCSLuaFile(dir.. "/".. v)
        end
        if string.StartWith(v, "cl") then
            if CLIENT then 
                local load = include(dir.. "/".. v)
                if load then load() end
            end

            AddCSLuaFile(dir.. "/".. v)
        end

        if string.StartWith(v, "sv") then
            if SERVER then 
                local load = include(dir.. "/".. v)
                if load then load() end
            end
        end
    end
end

function OAWC.Initialize:LoadFramework()
    OAWC.Initialize:LoadDir("oawc/config")
    OAWC.Initialize:LoadDir("oawc/core/initial")
    OAWC.Initialize:LoadDir("oawc/core/sql")
    OAWC.Initialize:LoadDir("oawc/library")
end


if GAMEMODE then 
    OAWC.Initialize:LoadFramework()
end
OAWC.Initialize:LoadFramework()
hook.Add("InitPostEntity", "OAWC.Framework.Initialize", function()
    OAWC.Initialize:LoadFramework()
end)





































