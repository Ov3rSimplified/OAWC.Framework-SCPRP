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
--[[ NETMESSAGES ]]

util.AddNetworkString("OAWC.CharSys.RequestCompressedData")
util.AddNetworkString("OAWC.CharSys.CreateCharacter")
util.AddNetworkString("OAWC.CharSys.UpdateNumberInformation")
util.AddNetworkString("OAWC.CharSys.SelectCharacter")
util.AddNetworkString("OAWC.CharSys.DeleteCharacter")
util.AddNetworkString("OAWC.CharSys.SelectSCP")
 
local function CreateCharacter(len,ply)
    local read = net.ReadCompressedTable()
    local tos = tostring
    local chari = {
        Age = read.age,
        Weight = read.weight,
        Gender = read.gender,
        REP = read.REP,
        STP = read.STP,
        SPP = read.SPP,
        SAP = read.SAP
    }

    local lastjob = "null"
    if read.kind == "FDP" then 
        lastjob = OAWC.Config.StarterJobs.FDP
    elseif read.kind == "DCP" then 
        lastjob = OAWC.Config.StarterJobs.DCP
    end

    OAWC.SQL:Query("INSERT INTO `OAWC_Character` (sid, name, lastjob, jobkind, inventory, other) VALUES('" .. ply:SteamID() .. "', '" .. tostring(read.name) .. "', '" .. tostring(lastjob) .. "', '" .. tostring(read.kind) .. "', '".. util.TableToJSON({}) .. "', '" .. util.TableToJSON(chari) .. "')", nil, OAWC.SQL.Error)
    hook.Run("OAWC.CharSys.CreateCharacter", ply, read.name, read.kind)
end net.Receive("OAWC.CharSys.CreateCharacter", CreateCharacter)

local function SelectCharacter(len,ply)
    local read = net.ReadInt(32)
    local str = net.ReadString()
    
    ply.CharacterID = read
    ply.CharacterKind = str

    ply:SetSpectatorMode(false)
    ply:changeTeam(tonumber(OAWC.Charactersystem.Source.Characters[ply:SteamID()][str].lastjobinnum), true, true)
    ply:setDarkRPVar("rpname", tostring(OAWC.Charactersystem.Source.Characters[ply:SteamID()][str].name))

    net.Start("OAWC.CharSys.SelectCharacter")
    net.WriteInt(read, 32)
    net.WriteString(str) 
    net.Send(ply)
    hook.Run("OAWC.CharSys.SelectCharacter", ply, read, str)
end net.Receive("OAWC.CharSys.SelectCharacter", SelectCharacter)


local function SelectSCP(len,ply)    
    ply.CharacterID = -1
    ply.CharacterKind = "SCP"

    ply:SetSpectatorMode(false)
    ply:changeTeam(tonumber(OAWC.Config.StarterJobs.SCP), true, true)
    ply:setDarkRPVar("rpname", "SCP")


    net.Start("OAWC.CharSys.SelectCharacter")
    net.WriteInt(-1, 32)
    net.WriteString("SCP")
    net.Send(ply)
    hook.Run("OAWC.CharSys.SelectCharacter", ply, -1, "sCP")
end net.Receive("OAWC.CharSys.SelectSCP", SelectSCP)

local function RequestCompressedData(len,ply)

    OAWC.SQL:Query([[SELECT * FROM `OAWC_Character`]], function(data)
        local synctable = {} 
        for k,v in pairs(data) do  
            local mT = {
                [v.sid] = { 
                    [v.jobkind] = {
                        ID = v.ID,
                        sid = v.sid,
                        name = v.name,
                        lastjob = RPExtraTeams[tonumber(v.lastjob)].command,
                        lastjobinnum = tonumber(v.lastjob),
                        jobkind = v.jobkind,
                        inventory = v.inventory,
                        other = v.other,
                    }
                } 
            } 
            table.Merge(synctable,mT)
        end
        OAWC.Charactersystem.Source.Characters = synctable
        net.Start("OAWC.CharSys.RequestCompressedData")
        net.WriteCompressedTable(synctable)
        net.Broadcast()
    end, OAWC.SQL.Error)
end net.Receive("OAWC.CharSys.RequestCompressedData", RequestCompressedData)

local function DeleteCharacter(len,ply)
    local int = net.ReadInt(32)
    if not OAWC.Charactersystem.Source.Characters[ply:SteamID()]["DCP"] or not OAWC.Charactersystem.Source.Characters[ply:SteamID()]["FDP"] and ply.CharacterID == -1 then 
        ply:SetSpectatorMode(true)
        ply:setDarkRPVar("rpname",  "Spectator")
        ply.CharacterID = 0
        ply.CharacterKind = ""
        net.Start("OAWC.CharSys.UpdateNumberInformation")
        net.WriteInt(0, 32)
        net.Send(ply)
    end 
    if ply.CharacterID == int then
        ply:SetSpectatorMode(true)
        ply:setDarkRPVar("rpname",  "Spectator")
        ply.CharacterID = 0
        ply.CharacterKind = ""
        net.Start("OAWC.CharSys.UpdateNumberInformation")
        net.WriteInt(0, 32)
        net.Send(ply)
    end
    hook.Run("OAWC.CharSys.DeleteCharacter", ply, int)
    OAWC.SQL:Query("DELETE FROM `OAWC_Character` WHERE ID = '" .. int .. "'", nil, OAWC.SQL.Error)
end net.Receive("OAWC.CharSys.DeleteCharacter", DeleteCharacter)

--[[
    METAFUNCTIONS
]]
local PLAYER = FindMetaTable("Player")

function PLAYER:GetCharacterID()

end

--[[
    Hooks
]]
hook.Add("OAWC.CharSys.CreateCharacter", "OAWC.CharSys.CreateCharacter", nil)
hook.Add("OAWC.CharSys.SelectCharacter", "OAWC.CharSys.SelectCharacter", nil)
hook.Add("OAWC.CharSys.DeleteCharacter", "OAWC.CharSys.DeleteCharacter", nil)