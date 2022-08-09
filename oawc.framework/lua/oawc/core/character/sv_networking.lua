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
--[[ NETMESSAGES ]]

util.AddNetworkString("OAWC.CharSys.CreateCharacter")
util.AddNetworkString("OAWC.CharSys.UpdateNumberInformation")
util.AddNetworkString("OAWC.CharSys.SelectCharacter")
util.AddNetworkString("OAWC.CharSys.DeleteCharacter")
util.AddNetworkString("OAWC.CharSys.SelectSCP")
util.AddNetworkString("OAWC.CharSys.UpdateName")
util.AddNetworkString("OAWC.CharSys.RequestPlayerCharacter")

local function CreateCharacter(len,ply)
    local read = net.ReadCompressedTable()
    local ss = SQLStr
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

    OAWC.SQL:Query("INSERT INTO `OAWC_Character` (sid, name, age, gender, weight, wallet, sap, rep, spp, stp, lastjob, jobkind, inventory, model, level, playerdetails) VALUES('" .. ply:SteamID() .. "', " .. ss(read.name) .. ", " .. ss(read.age) .. ", " .. ss(read.gender) .. ", " .. ss(read.weight) .. ", " .. ss(1) .. ", " .. ss(read.SAP) .. ", " .. ss(read.REP) .. ", " .. ss(read.SPP) .. ",  " .. ss(read.STP) .. ", " .. ss(lastjob) .. ", " .. ss(read.kind) .. ", " .. ss(util.TableToJSON({Slot = {[1] = "NULL", [2] = "NULL", [3] = "NULL"}, Items = {}})) .. ",  " .. ss("SOON") ..",  " .. ss(0) .. ", " .. ss(util.TableToJSON({})) .. ")", nil, OAWC.SQL.Error)
    hook.Run("OAWC.CharSys.CreateCharacter", ply, read.name, read.kind)
end net.Receive("OAWC.CharSys.CreateCharacter", CreateCharacter)

local function SelectCharacter(len,ply)
    local read = net.ReadInt(32)
    local str = net.ReadString()
    local sid = net.ReadString()

    if ply:SteamID() == sid then
        if ply.CharacterID == read then return end
        if not isnumber(read) then return end
        if not isstring(str) then return end
        if not str == "FDP" and not str == "DCP" then return end

        ply.CharacterID = read
        ply.CharacterKind = str

        ply:SetSpectatorMode(false)
        ply:setDarkRPVar("money", tonumber(ply.Characters[str].wallet))
        print(ply.Characters[str].wallet)
        ply:changeTeam(tonumber(ply.Characters[str].lastjobinnum), true, true)
        ply:setDarkRPVar("rpname", tostring(ply.Characters[str].name))
        ply:Spawn()


        net.Start("OAWC.CharSys.SelectCharacter")
        net.WriteInt(read, 32)
        net.WriteString(str)
        net.Send(ply)
        hook.Run("OAWC.CharSys.SelectCharacter", ply, read, str)

        OAWC:Notify("info", ply, "Viel Erfolg!", "Viel Spaß und Erfolg wünschen wir dir beim Spielen <3", 1)
    else
        --ply:Kick("You've been kicked for try to cheat! #ErrorCode 12")
        print("[OAWC] " .. ply:Nick() .. " tried to cheat!")
        return
    end
end net.Receive("OAWC.CharSys.SelectCharacter", SelectCharacter)


local function DarkRPValueChanged(ply, varname, oldValue, newValue)
    if ply.Characters == nil or table.IsEmpty(ply.Characters) then return end
    if ply.CharacterID == 0 or ply.CharacterKind == nil then return end
    if varname == "money" then
        OAWC.SQL:Query("UPDATE `OAWC_Character` SET `wallet` = " .. newValue .. " WHERE `ID` = " .. SQLStr(ply.Characters[ply.CharacterKind].id) .. "", nil, OAWC.SQL.Error)
        print(ply.Characters[ply.CharacterKind].wallet)
    end

end
hook.Add("DarkRPVarChanged", "OAWC.SnychDRPV", DarkRPValueChanged)

concommand.Add("AD" , function(ply, cmd, args)
    ply:addMoney(tonumber(args[1]))
end)

local function SelectSCP(len,ply)
    ply.CharacterID = -1
    ply.CharacterKind = "SCP"

    ply:SetSpectatorMode(false)
    ply:changeTeam(tonumber(OAWC.Config.StarterJobs.SCP), true, true)
    ply:setDarkRPVar("rpname", "SCP")

    ply:Spawn()

    net.Start("OAWC.CharSys.SelectCharacter")
    net.WriteInt(-1, 32)
    net.WriteString("SCP")
    net.Send(ply)
    hook.Run("OAWC.CharSys.SelectCharacter", ply, -1, "sCP")
end net.Receive("OAWC.CharSys.SelectSCP", SelectSCP)

local function RequestPlayerCharacter(len,ply)
    ply.Characters = ply.Characters or {}
    OAWC.SQL:Query("SELECT * FROM OAWC_Character WHERE sid = " .. SQLStr(ply:SteamID()), function(data)
        local r = {}
        if data == nil then
            r = {}
            ply.Characters = r
            net.Start("OAWC.CharSys.RequestPlayerCharacter")
            net.WriteCompressedTable(r)
            net.Broadcast()
            return
        end

            for k,v in pairs(data) do
                r[v.jobkind] = {
                    id = v.ID,
                    sid = v.sid,
                    name = v.name,
                    age = v.age,
                    gender = v.gender,
                    weight = v.weight,
                    wallet = v.wallet,
                    lastjob = RPExtraTeams[tonumber(v.lastjob)].command,
                    lastjobinnum = tonumber(v.lastjob),
                    jobkind = v.jobkind,
                    inventory = util.JSONToTable(v.inventory),
                    playerdetails = util.JSONToTable(v.playerdetails)
                }
            end

            ply.Characters = r
            --PrintTable(r)

            PrintTable(ply.Characters)

        net.Start("OAWC.CharSys.RequestPlayerCharacter")
        net.WriteCompressedTable(r)
        net.Broadcast()

    end, OAWC.SQL.Error)
end
net.Receive("OAWC.CharSys.RequestPlayerCharacter", RequestPlayerCharacter)

local function DeleteCharacter(len,ply)
    local int = net.ReadInt(32)
    if not ply.Characters["DCP"] or not ply.Characters["FDP"] and ply.CharacterID == -1 then
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
    OAWC.SQL:Query("DELETE FROM OAWC_Character WHERE ID = " .. int .. "'", nil, OAWC.SQL.Error)
end net.Receive("OAWC.CharSys.DeleteCharacter", DeleteCharacter)

local function UpdateName(len,ply)
    local int = net.ReadInt(32)
    local str = net.ReadString()
    OAWC.SQL:Query("UPDATE OAWC_Character SET name = " .. SQLStr(str) .. " WHERE ID = " .. int, nil,  OAWC.SQL.Error)
end
net.Receive("OAWC.CharSys.UpdateName", UpdateName)


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
