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

local function RequestPlayerCharacter()
    local read = net.ReadCompressedTable()
    LocalPlayer().Characters = read
    PrintTable(LocalPlayer().Characters)
end
net.Receive("OAWC.CharSys.RequestPlayerCharacter", RequestPlayerCharacter)

local function SelectCharacter()
    local read = net.ReadInt(32)
    LocalPlayer().CharacterID = read
    LocalPlayer().CharacterKind = net.ReadString()
end net.Receive("OAWC.CharSys.SelectCharacter", SelectCharacter)

local function UpdateNumberInformation()
    LocalPlayer().CharacterID = net.ReadInt(32)
    LocalPlayer().CharacterKind = net.ReadString() or ""
end net.Receive("OAWC.CharSys.UpdateNumberInformation", UpdateNumberInformation)


concommand.Add("df", function()
    net.Start("OAWC.CharSys.RequestPlayerCharacter")
    net.SendToServer()
end)