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

local delay = 0
hook.Add( "PlayerButtonDown", "OAWC.ServerBindCheck", function( ply, button )
    if delay < CurTime() then
        if not OAWC.ConfigTableAvailable() then
        else
            for k,v in pairs(OAWC.CoreConfig.Binds) do
                if button == v.Key then
                    if v.Executekind == "URL" then
                        gui.OpenURL( v.Execute )
                    elseif v.Executekind == "Command" then
                        LocalPlayer():ConCommand(tostring(v.Execute))
                    elseif v.Executekind == "Runstring" then
                        RunString( v.Execute )
                    elseif v.Executekind == "Function" then
                        local functi = CompileString(v.Execute, v.Name, false)
                        functi()
                    end
                end
            end
            delay = CurTime() + 0.2
        end
    end
end)