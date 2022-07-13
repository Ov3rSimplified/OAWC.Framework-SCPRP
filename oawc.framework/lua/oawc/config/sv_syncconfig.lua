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

util.AddNetworkString("OAWC.Config.Set");
util.AddNetworkString("OAWC.Config.Get");
util.AddNetworkString("OAWC.Config.Sync");
             
local function Set(len,ply)
    local read = net.ReadCompressedTable();
    if istable(read) then 
        --if ply:HasPermission("OAWC_Config") then 
            table.Merge(OAWC.CoreConfig,read);
            if file.IsDir("OAWC/Config", "DATA") then
                file.Write("OAWC/Config/config.json", util.TableToJSON(OAWC.CoreConfig));
            else
                file.CreateDir("OAWC/Config");
                file.Write("OAWC/Config/config.json", util.TableToJSON(OAWC.CoreConfig));
            end;
       -- else
          --  return;
        --    ply:Kick("You are not allowed to change the config!");
       -- end;
    end;
end; net.Receive("OAWC.Config.Set", Set);

local function Get(len,ply)
    if file.Exists("OAWC/Config/config.json", "DATA") then
        local read = util.JSONToTable(file.Read("OAWC/Config/config.json", "DATA"));
        if istable(read) then
            local ct = table.Copy(OAWC.CoreConfig); 
            local rt = table.GetKeys(read);
            // Select the keys from the config that are not in the read config. and set the vars that in the read config to nil
            for k,v in pairs(ct) do
                for i=1, table.Count(rt) do
                    if k == rt[i] then
                        ct[k] = nil;     
                    end;
                end;
            end;
            table.Merge(read,ct);  // Merge the configs together.
            --PrintTable(read);
            net.Start("OAWC.Config.Sync");
            net.WriteCompressedTable(read);
            net.Send(ply);
        elseif read == nil then
            net.Start("OAWC.Config.Sync");
            net.WriteCompressedTable(OAWC.CoreConfig);
            net.Send(ply);
        end;
    end;
end; net.Receive("OAWC.Config.Get", Get);

