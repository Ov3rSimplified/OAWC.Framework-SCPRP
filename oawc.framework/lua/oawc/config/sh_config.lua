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
OAWC.Config = {}
OAWC.Config.Humans = {}

OAWC.Config.Humans.MinCreateWeight = 45
OAWC.Config.Humans.MaxCreateWeight = 200

OAWC.Config.Humans.MaxCreateAge = 40
OAWC.Config.Humans.MinCreateAge = 18
OAWC.Config.Humans.MinNameLength = 3
OAWC.Config.Humans.MaxNameLength = 20

OAWC.Config.Humans.GenderModels = {
    ["MALE"] = {},
    ["FEMALE"] = {}
}

OAWC.Config.RegisteredJobs = {
    ["FDP"] = {
        [TEAM_Jane] = true,
        [RDSRP_21stSOM] = true,
    },
    ["DCP"] = {
        [RDSRP_21stSOM] = true,
    },
    ["SCP"] = {
        [TEAM_SCPSELECT] = true,
    } 
}

OAWC.Config.StarterJobs =  {
    FDP = TEAM_Jane,
    DCP = TEAM_Jane,
    SCP = TEAM_SCPSELECT,
}


