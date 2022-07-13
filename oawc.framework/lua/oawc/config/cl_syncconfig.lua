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
 
 
   
// ** NET
local function Sync()
    local read = net.ReadCompressedTable()
    OAWC.CoreConfig = read
end; net.Receive("OAWC.Config.Sync", Sync);


// ** Globals

function OAWC.SetConfig()
    net.Start("OAWC.Config.Set");   
    net.WriteCompressedTable(OAWC.CoreConfig);
    net.SendToServer();
end;

function OAWC.GetConfig()
    net.Start("OAWC.Config.Get");
    net.SendToServer();
end; 
--OAWC.GetConfig()


// ** MENU

function OAWC.UI:OpenConfig()
    if LocalPlayer():HasPermission("OAWC_Config") then 

        local frame = vgui.Create("DFrame");
        frame:SetSize(850,500);
        frame:Center();
        frame:SetTitle("OAWC Config");
        frame:MakePopup();

        local l = {};

        l.psheet = vgui.Create("DPropertySheet", frame);
        l.psheet:Dock(FILL);

        l.general = vgui.Create("DPanel", l.psheet);
        l.psheet:AddSheet( "General", l.general, nil );
 
        l.general.tab = vgui.Create("DColumnSheet", l.general);
        l.general.tab:Dock(FILL); 

        l.AddInformations = function(parent, title, description)
            local titlee = vgui.Create("DLabel", parent);
            titlee:Dock(TOP);
            titlee:DockMargin(0,5,0,0);
            titlee:SetText(title);
            titlee:SetTextColor(Color(0,0,0,255));
            titlee:SetFont("DermaLarge");
            titlee:SizeToContents();

            /*

            local descriptionn = vgui.Create("RichText", parent);
                descriptionn:Dock(TOP);
                descriptionn:InsertColorChange( 10, 10, 10, 255 );
                descriptionn:AppendText(description);
                descriptionn:SetTall(ScrH()*0.06);
                function descriptionn:PerformLayout()
                    self:SetFontInternal("DermaDefault");
                end;*/
        end;

        --[[
            -- ## Information ## --
            name @ string: Name of the config
            description @ string: Description of the config
            savefunc @ function: Function to save the config
            element @ string: types of the element (Text, NumberText, DropDown, Checkbox)
            extra @ table: extra data for the element (ONLY WHEN YOU HAVE THE DROPDOWN)
             -- ExtraTable = {
                {
                    value = "",
                    data = "",
                    select = false,
                    icon = "nil",
                }
             }
        ]]--
        l.SimpleEditField = function(parent, name, description, var,  savefunc, element, extra)
            if not element == "DropDown" then extra = nil end 
            local Panel = vgui.Create("DPanel", parent);
            Panel:Dock(TOP);
            Panel:DockMargin(5,5,5,0);
            Panel:SetTall(ScrH()*0.06);
            Panel.Paint = function(self, w, h)
                draw.RoundedBox(7.5, 0, 0, w, h, Color(108,111,114,255));
            end;
                Panel.Name = vgui.Create("DLabel", Panel);
                Panel.Name:Dock(LEFT);
                Panel.Name:DockMargin(5,0,0,0);
                Panel.Name:SetText(name);
                Panel.Name:SetTextColor(Color(255,255,255));
                Panel.Name:SetFont("ScoreboardDefault");
                Panel.Name:SizeToContents();

                Panel.Configfield = vgui.Create("DPanel", Panel);
                Panel.Configfield:Dock(RIGHT);
                Panel.Configfield:DockMargin(10,10,10,10);
                Panel.Configfield:SetWide(ScrW()*0.2);

                if element == "Text" or element == "NumberText" then 
                    Panel.Configfield.TextEntry = vgui.Create("DTextEntry", Panel.Configfield);
                    Panel.Configfield.TextEntry:Dock(LEFT);
                    Panel.Configfield.TextEntry:DockMargin(0,0,0,0);
                    Panel.Configfield.TextEntry:SetWide(ScrW()*0.15);
                    Panel.Configfield.TextEntry:SetPlaceholderText("Enter " .. name .. "...");
                    Panel.Configfield.TextEntry:SetText(tostring(var) or ""); 
                    Panel.Configfield.TextEntry:SetFont("ScoreboardDefault");
                    if element == "NumberText" then 
                        Panel.Configfield.TextEntry:SetNumeric(true);
                    end;
                elseif element == "DropDown" then 
                    Panel.Configfield.DropDown = vgui.Create("DComboBox", Panel.Configfield);
                    Panel.Configfield.DropDown:Dock(LEFT);
                    Panel.Configfield.DropDown:DockMargin(0,0,0,0);
                    Panel.Configfield.DropDown:SetWide(ScrW()*0.15);
                    Panel.Configfield.DropDown:SetValue( tostring(var) or "Select" )
                    Panel.Configfield.DropDown:SetFont("ScoreboardDefault");
                    for k,v in pairs(extra) do 
                        Panel.Configfield.DropDown:AddChoice(v.value, v.data, v.select, v.icon);
                    end;
                    function Panel.Configfield.DropDown:OnSelect( index, text, data )
                        savefunc(data);
                    end;
                elseif element == "Checkbox" then
                    Panel.Configfield:SetWide(ScrH()*0.17);
                    Panel.Configfield.Checkbox = vgui.Create("DCheckBox", Panel.Configfield);
                    Panel.Configfield.Checkbox:Dock(LEFT);
                    Panel.Configfield.Checkbox:DockMargin(0,0,5,0);
                    Panel.Configfield.Checkbox:SetWide(ScrW()*0.02);
                    Panel.Configfield.Checkbox:SetValue(var or false);
                    function Panel.Configfield.Checkbox:OnChange( bVal )
                        savefunc(bVal);
                    end;
                end;

                Panel.I = vgui.Create("DButton", Panel.Configfield);
                Panel.I:Dock(LEFT);
                Panel.I:DockMargin(0,0,0,0);
                Panel.I:SetWide(ScrW()*0.01);
                Panel.I:SetText("I");
                Panel.I:SetToolTip("Informations");
                Panel.I:SetTextColor(Color(0,0,0));
                Panel.I:SetFont("DermaLarge");

                Panel.Save = vgui.Create("DButton", Panel.Configfield);
                Panel.Save:Dock(FILL);
                Panel.Save:DockMargin(0,0,0,0);
                Panel.Save:SetText("Save");
                Panel.Save:SetToolTip("Save Data");
                Panel.Save:SetTextColor(Color(0,0,0));
                Panel.Save:SetFont("DermaLarge");
                function Panel.Save:DoClick()
                    if element == "Text" then 
                        savefunc(Panel.Configfield.TextEntry:GetValue());
                    elseif element == "NumberText" then 
                        savefunc(tonumber(Panel.Configfield.TextEntry:GetValue()));
                    end;          
                end;
        end;    


        local items = {};

        local AddConfig = function(data) 
            data.name = data.name or "N/A";
            data.description = data.description or "N/A";
            data.VGUI = data.VGUI or nil;
        
            items[data.name] = data;
            items[data.name].name = nil;
        end;
        
            AddConfig({
                name = "Main",
                description = "Main Config",
                VGUI = function(parent)
                    l.AddInformations(parent, "Main", "LOREM IMPSUM ALLALOREM IMPSUM ALLALOREM IMPSUM ALLALOREM IMPSUM ALLALOREM IMPSUM ALLALOREM IMPSUM ALLALOREM IMPSUM ALLALOREM IMPSUM ALLALOREM IMPSUM ALLA");
                  --  l.SimpleEditField(parent, "Peter1", "...", OAWC.CoreConfig.Peter2, function(data) 
                --        OAWC.CoreConfig.Peter2 = data
                --        OAWC.SetConfig();
                --    end, "Checkbox" );
                end;
            });

            AddConfig({
                name = "Binds",
                description = "Main Config",
                VGUI = function(parent)
                    l.AddInformations(parent, "Binds", "Config for Serverbinds!");
                    local c = {}


                    c.Scroll = vgui.Create("DScrollPanel", parent);
                    c.Scroll:Dock(FILL);
                    c.Scroll:DockMargin(0,0,0,0);


                    if OAWC.CoreConfig.Binds == nil or table.IsEmpty(OAWC.CoreConfig.Binds) then 
                        c.noB = vgui.Create("DButton", c.Scroll);
                        c.noB:Dock(TOP);
                        c.noB:DockMargin(5,5,5,5);
                        c.noB:SetTall(ScrH()*0.05);
                        c.noB:SetText("No Data found!");
                        c.noB:SetTextColor(Color(0,0,0));
                        c.noB:SetFont("DermaLarge");                                      
                    else
                        for k,v in pairs(OAWC.CoreConfig.Binds) do
                            
                        end;
                    end;

                    c.bottom = vgui.Create("DPanel", parent);
                    c.bottom:Dock(BOTTOM);
                    c.bottom:DockMargin(0,0,0,0);
                    c.bottom:SetTall(ScrH()*0.03);


                    c.bottom.Create = vgui.Create("DButton", c.bottom);
                    c.bottom.Create:Dock(LEFT);
                    c.bottom.Create:DockMargin(5,5,5,5);
                    c.bottom.Create:SetWide(ScrW()*0.1);
                    c.bottom.Create:SetText("[+] Create");
                    c.bottom.Create:SetToolTip("Create a new Serverbind");
                    c.bottom.Create:SetFont("DermaDefault");

                    c.bottom.Search = vgui.Create("DTextEntry", c.bottom);
                    c.bottom.Search:Dock(LEFT);
                    c.bottom.Search:DockMargin(5,5,5,5);
                    c.bottom.Search:SetWide(ScrW()*0.1);
                    c.bottom.Search:SetPlaceholderText("Search...");
                    c.bottom.Search:SetFont("DermaDefault");
                end;
            });

            for k,v in pairs(items) do 
                v.pnl = vgui.Create("DPanel", l.general.tab);
                v.pnl:Dock( FILL );
                l.general.tab:AddSheet( k, v.pnl, nil );
                v.VGUI(v.pnl);
            end;
    else
        return;
    end;
end;



concommand.Add("oawc_config", OAWC.UI.OpenConfig);
