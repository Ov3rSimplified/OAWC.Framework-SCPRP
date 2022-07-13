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
--[[

    sql connection: ID, sid, name, lastjob


]]  


if SERVER then 

    local query 
    if OAWC.SQL:UsingMySQL() then 
        query = [[
            CREATE TABLE IF NOT EXISTS `OAWC_Character` (
                `ID` INT NOT NULL AUTO_INCREMENT,
                `sid`TEXT NOT NULL,
                `name` TEXT NOT NULL,
                `lastjob` TEXT NOT NULL,
                `jobkind` TEXT NOT NULL,
                `inventory`TEXT NOT NULL,
                `other` TEXT NOT NULL,
                PRIMARY KEY (`ID`)
            );
            ]] 
    else
        query = [[ 
            CREATE TABLE IF NOT EXISTS `OAWC_Character` (
                `ID` INT NOT NULL AUTO_INCREMENT,
                `sid`TEXT NOT NULL,
                `name` TEXT NOT NULL,
                `lastjob` TEXT NOT NULL,
                `jobkind` TEXT NOT NULL,
                PRIMARY KEY (`id`)
                );
            ]]
    end 
    
    OAWC.SQL:Query(query, nil, OAWC.SQL.Error)
end
