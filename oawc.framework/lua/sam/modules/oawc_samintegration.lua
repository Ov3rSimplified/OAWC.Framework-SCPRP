if SAM_LOADED then return end

local sam, command = sam, sam.command

sam.command.set_category("OAWC")

sam.permissions.add("OAWC_Test", "OAWC", "admin") 
sam.permissions.add("OAWC_Config", "OAWC", "admin") 



command.new("enablescroll")
    :Aliases("es")

    :SetPermission("OAWC_EnableScroll", "OAWC", "admin")

	:Help("Enable Scroll")

    :OnExecute(function(ply)
        print("Scroll Enabled")
    end)
:End()