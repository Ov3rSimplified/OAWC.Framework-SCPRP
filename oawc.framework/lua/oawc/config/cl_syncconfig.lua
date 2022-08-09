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
    local read = net.ReadCompressedTable();
    OAWC.CoreConfig = read;
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
OAWC.GetConfig()


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


        // ** Character Manage Init
        l.character = vgui.Create("DPanel", l.psheet);
        l.psheet:AddSheet( "Character Manager", l.character, nil );

        l.AddInformations = function(parent, title, description)
            local titlee = vgui.Create("DLabel", parent);
            titlee:Dock(TOP);
            titlee:DockMargin(0,5,0,0);
            titlee:SetText(title);
            titlee:SetTextColor(Color(0,0,0,255));
            titlee:SetFont("DermaLarge");
            titlee:SizeToContents();
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
                elseif element == "ODropDown" then
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
                elseif element == "Binder" then
                    Panel.Configfield.Binder = vgui.Create("DBinder", Panel.Configfield);
                    Panel.Configfield.Binder:DockMargin(0,0,0,0);
                    Panel.Configfield.Binder:SetWide(ScrW()*0.15);
                    Panel.Configfield.Binder:Dock(LEFT);
                    if var == nil or var == KEY_NONE then
                        Panel.Configfield.Binder:SetValue(KEY_NONE);
                    else
                        Panel.Configfield.Binder:SetValue(var);
                    end;
                    function Panel.Configfield.Binder:OnChange( bVal )
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

                if extra == "OnEnter" and element == "Text" or element == "NumberText" then
                    Panel.Configfield:SetWide(ScrW()*0.16);
                    Panel.Configfield.TextEntry.OnEnter = function()
                        savefunc(Panel.Configfield.TextEntry:GetValue());
                    end;
                end;
                if extra == "OnChange" and element == "Text" or element == "NumberText" then
                    Panel.Configfield:SetWide(ScrW()*0.16);
                    Panel.Configfield.TextEntry.OnChange = function()
                        savefunc(Panel.Configfield.TextEntry:GetValue());
                    end;
                end;
                if extra == "OnChange" and element == "Binder" then
                    Panel.Configfield:SetWide(ScrW()*0.16);
                end;
                if element == "ODropDown" then
                    Panel.Configfield:SetWide(ScrW()*0.16);
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
                    local itemss = {}

                    c.Scroll = vgui.Create("DScrollPanel", parent);
                    c.Scroll:Dock(FILL);
                    c.Scroll:DockMargin(0,0,0,0);

                    local function tk()
                        itemss = {}
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
                                c.noB = vgui.Create("DPanel", c.Scroll);
                                c.noB:Dock(TOP);
                                c.noB:DockMargin(5,5,5,5);
                                c.noB:SetTall(ScrH()*0.05);
                                c.noB.Paint = function(self, w, h)
                                    draw.RoundedBox(0, 0, 0, w, h, Color(234,234,234,255));
                                    surface.SetDrawColor(Color(0,0,0,255));
                                    surface.DrawOutlinedRect(0, 0, w,h,1);
                                end;
                                c.noB.Text = vgui.Create("DLabel", c.noB);
                                c.noB.Text:Dock(LEFT);
                                c.noB.Text:DockMargin(5,5,5,5);
                                c.noB.Text:SetWide(ScrW()*0.1)
                                c.noB.Text:SetText(tostring(v.Name));
                                c.noB.Text:SetTextColor(Color(0,0,0));
                                c.noB.Text:SetFont("DermaLarge");

                                table.insert(itemss, c.noB);

                                c.noB.Edit = vgui.Create("DButton", c.noB);
                                c.noB.Edit:Dock(RIGHT);
                                c.noB.Edit:DockMargin(5,5,5,5);
                                c.noB.Edit:SetWide(ScrW()*0.02)
                                c.noB.Edit:SetText("Delete");
                                c.noB.Edit:SetTextColor(Color(0,0,0));
                                c.noB.Edit.DoClick = function()
                                    OAWC.CoreConfig.Binds[k] = nil;
                                    OAWC.SetConfig();
                                    c.Scroll:Clear();
                                    tk()
                                end;

                                c.noB.Edit = vgui.Create("DButton", c.noB);
                                c.noB.Edit:Dock(RIGHT);
                                c.noB.Edit:DockMargin(5,5,5,5);
                                c.noB.Edit:SetWide(ScrW()*0.02)
                                c.noB.Edit:SetText("Edit");
                                c.noB.Edit:SetTextColor(Color(0,0,0));
                                c.noB.Edit.DoClick = function()
                                    c.editPanel(OAWC.CoreConfig.Binds[k])
                                end;
                            end;
                        end;
                    end;
                        tk()

                    c.bottom = vgui.Create("DPanel", parent);
                    c.bottom:Dock(BOTTOM);
                    c.bottom:DockMargin(0,0,0,0);
                    c.bottom:SetTall(ScrH()*0.03);

                    local createPanel = function()
                        c.Scroll:Clear()
                        c.bottom.Search:SetVisible(false)
                        c.bottom.Create:SetVisible(false)

                        local namee = "";
                        local bind = KEY_NONE;
                        local kind = "";
                        local execute = "";

                        c.bottom.savee = vgui.Create("DButton", c.bottom);
                        c.bottom.savee:Dock(LEFT);
                        c.bottom.savee:DockMargin(5,5,5,5);
                        c.bottom.savee:SetWide(ScrW()*0.1);
                        c.bottom.savee:SetText("S A V E");
                        c.bottom.savee:SetToolTip("Create a new Serverbind");
                        c.bottom.savee:SetFont("DermaDefault");
                        c.bottom.savee.DoClick = function()
                            if namee == "" then return end
                            if bind == KEY_NONE then return end
                            if kind == "" then return end
                            if execute == "" then return end

                            local st = {
                                Name = namee,
                                Key = bind,
                                Executekind = kind,
                                Execute = execute,
                            };
                            table.insert(OAWC.CoreConfig.Binds, st);
                            OAWC.SetConfig();

                          PrintTable(st)
                            c.Scroll:Clear()
                            c.bottom.Create:SetVisible(true);
                            c.bottom.Search:SetVisible(true);
                            c.bottom.backk:Remove();
                            c.bottom.savee:Remove();
                            tk()
                        end
                        c.bottom.backk = vgui.Create("DButton", c.bottom);
                        c.bottom.backk:Dock(LEFT);
                        c.bottom.backk:DockMargin(5,5,5,5);
                        c.bottom.backk:SetWide(ScrW()*0.1);
                        c.bottom.backk:SetText("B A C K ");
                        c.bottom.backk:SetToolTip("Create a new Serverbind");
                        c.bottom.backk:SetFont("DermaDefault");
                        c.bottom.backk.DoClick = function()
                            c.Scroll:Clear();
                            c.bottom.Create:SetVisible(true);
                            c.bottom.Search:SetVisible(true);
                            c.bottom.backk:Remove();
                            c.bottom.savee:Remove();
                            tk()
                        end

                        local editp = vgui.Create("DPanel", c.Scroll);
                        editp:Dock(TOP);
                        editp:DockMargin(5,5,5,5);
                        editp:SetTall(ScrH()*0.3);
                        editp:SlideDown(.4);
                        editp.Paint = function(self, w, h)
                            draw.RoundedBox(0, 0, 0, w, h, Color(234,234,234,255));
                            surface.SetDrawColor(Color(0,0,0,255));
                            surface.DrawOutlinedRect(0, 0, w,h,1);
                        end;

                        local title = vgui.Create("DLabel", editp);
                        title:Dock(TOP);
                        title:DockMargin(5,5,5,5);
                        title:SetTall(ScrH()*0.02)
                        title:SetText("");
                        title.Paint = function(self,w,h)
                            draw.SimpleText("Create Server Bind", "DermaLarge", w/2, h/2, Color(0,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
                        end;

                        l.SimpleEditField(editp, "Name", "", namee,  function(bar) namee = bar;  end, "Text", "OnChange" );
                        l.SimpleEditField(editp, "Key", "", bind,  function(bar) bind = bar; end, "Binder", "OnChange" );
                        l.SimpleEditField(editp, "Kind", "", kind,  function(bar)  kind = bar;  end, "ODropDown", {
                            { value = "Command", data = "Command", select = false, icon = nil, },
                            { value = "RunString", data = "RunString", select = false, icon = nil, },
                            { value = "URL", data = "URL", select = false, icon = nil, },
                            { value = "Function", data = "Function", select = false, icon = nil, }
                        } );
                        l.SimpleEditField(editp, "Execute", "", execute,  function(bar) execute = bar; end, "Text", "OnChange" );
                    end

                    c.editPanel = function(va)
                        c.Scroll:Clear()
                        c.bottom.Search:SetVisible(false)
                        c.bottom.Create:SetVisible(false)

                        local namee = va.Name;
                        local bind =  va.Key;
                        local kind =  va.Executekind;
                        local execute = va.Execute;

                        c.bottom.savee = vgui.Create("DButton", c.bottom);
                        c.bottom.savee:Dock(LEFT);
                        c.bottom.savee:DockMargin(5,5,5,5);
                        c.bottom.savee:SetWide(ScrW()*0.1);
                        c.bottom.savee:SetText("S A V E");
                        c.bottom.savee:SetToolTip("Create a new Serverbind");
                        c.bottom.savee:SetFont("DermaDefault");
                        c.bottom.savee.DoClick = function()
                            if namee == "" then return end
                            if bind == KEY_NONE then return end
                            if kind == "" then return end
                            if execute == "" then return end

                            va.Name = namee;
                            va.Key = bind;
                            va.Executekind = kind;
                            va.Execute = execute;
                            OAWC.SetConfig();

                            c.Scroll:Clear()
                            c.bottom.Create:SetVisible(true);
                            c.bottom.Search:SetVisible(true);
                            c.bottom.backk:Remove();
                            c.bottom.savee:Remove();
                            tk()
                        end
                        c.bottom.backk = vgui.Create("DButton", c.bottom);
                        c.bottom.backk:Dock(LEFT);
                        c.bottom.backk:DockMargin(5,5,5,5);
                        c.bottom.backk:SetWide(ScrW()*0.1);
                        c.bottom.backk:SetText("B A C K ");
                        c.bottom.backk:SetToolTip("Create a new Serverbind");
                        c.bottom.backk:SetFont("DermaDefault");
                        c.bottom.backk.DoClick = function()
                            c.Scroll:Clear();
                            c.bottom.Create:SetVisible(true);
                            c.bottom.Search:SetVisible(true);
                            c.bottom.backk:Remove();
                            c.bottom.savee:Remove();
                            tk()
                        end

                        local editp = vgui.Create("DPanel", c.Scroll);
                        editp:Dock(TOP);
                        editp:DockMargin(5,5,5,5);
                        editp:SetTall(ScrH()*0.3);
                        editp:SlideDown(.4);
                        editp.Paint = function(self, w, h)
                            draw.RoundedBox(0, 0, 0, w, h, Color(234,234,234,255));
                            surface.SetDrawColor(Color(0,0,0,255));
                            surface.DrawOutlinedRect(0, 0, w,h,1);
                        end;

                        local title = vgui.Create("DLabel", editp);
                        title:Dock(TOP);
                        title:DockMargin(5,5,5,5);
                        title:SetTall(ScrH()*0.02)
                        title:SetText("");
                        title.Paint = function(self,w,h)
                            draw.SimpleText("Create Server Bind", "DermaLarge", w/2, h/2, Color(0,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
                        end;

                        l.SimpleEditField(editp, "Name", "", namee,  function(bar) namee = bar;  end, "Text", "OnChange" );
                        l.SimpleEditField(editp, "Key", "", bind,  function(bar) bind = bar; end, "Binder", "OnChange" );
                        l.SimpleEditField(editp, "Kind", "", kind,  function(bar)  kind = bar;  end, "ODropDown", {
                            { value = "Command", data = "Command", select = false, icon = nil, },
                            { value = "RunString", data = "RunString", select = false, icon = nil, },
                            { value = "URL", data = "URL", select = false, icon = nil, },
                            { value = "Function", data = "Function", select = false, icon = nil, }
                        } );
                        l.SimpleEditField(editp, "Execute", "", execute,  function(bar) execute = bar; end, "Text", "OnChange" );
                    end

                    c.bottom.Create = vgui.Create("DButton", c.bottom);
                    c.bottom.Create:Dock(LEFT);
                    c.bottom.Create:DockMargin(5,5,5,5);
                    c.bottom.Create:SetWide(ScrW()*0.1);
                    c.bottom.Create:SetText("[+] Create");
                    c.bottom.Create:SetToolTip("Create a new Serverbind");
                    c.bottom.Create:SetFont("DermaDefault");
                    c.bottom.Create.DoClick = function()
                        createPanel()
                    end

                    c.bottom.Search = vgui.Create("DTextEntry", c.bottom);
                    c.bottom.Search:Dock(LEFT);
                    c.bottom.Search:DockMargin(5,5,5,5);
                    c.bottom.Search:SetWide(ScrW()*0.1);
                    c.bottom.Search:SetPlaceholderText("Search...");
                    c.bottom.Search:SetFont("DermaDefault");

                    function c.bottom.Search:OnChange()
                        local search_text = self:GetText():lower();
                        if (#search_text == 0) then
                            for _,v in pairs(itemss) do
                                v:SetTall(80)
                            end
                        else
                            for _,v in pairs(itemss) do
                                if (v.Text:GetText():lower():find(search_text,1,true)) then
                                    v:SetTall(80)
                                else
                                    v:SetTall(0)
                                end
                            end
                        end
                    end
                end;
            });

            for k,v in pairs(items) do
                v.pnl = vgui.Create("DPanel", l.general.tab);
                v.pnl:Dock( FILL );
                l.general.tab:AddSheet( k, v.pnl, nil );
                v.VGUI(v.pnl);
            end;



            // -- ## CHARACTER MANAGER ZONE


                l.c = {};
                local ce = {};

                l.AddInformations(l.character,"Character Manager","");

                l.c.Mp = vgui.Create("DPanel", l.character);
                l.c.Mp:Dock(FILL);

                l.c.leftPanel = vgui.Create("DPanel", l.c.Mp);
                l.c.leftPanel:Dock(LEFT);
                l.c.leftPanel:SetWide(ScrW()*0.1);
                l.c.Right = vgui.Create("DScrollPanel", l.c.Mp);
                l.c.Right:Dock(FILL);

                    l.c.scroll = vgui.Create("DScrollPanel", l.c.leftPanel);
                    l.c.scroll:Dock(FILL);

                local function ccp()
                    net.Start("OAWC.CharSys.RequestCompressedData")
                    net.SendToServer()

                    timer.Simple(0.1, function()

                        if table.IsEmpty(OAWC.Charactersystem.Source.Characters) or OAWC.Charactersystem.Source.Characters == nil then
                            l.c.Button = vgui.Create("DButton", l.c.scroll);
                            l.c.Button:Dock(TOP);
                            l.c.Button:DockMargin(0,5,0,0);
                            l.c.Button:SetTall(ScrH()*0.02);
                            l.c.Button:SetText("NO DATA!");
                        else
                            for k, v in pairs(OAWC.Charactersystem.Source.Characters) do
                                l.c.Category = vgui.Create( "DCollapsibleCategory", l.c.scroll )
                                l.c.Category:SetLabel( k )
                                l.c.Category:Dock( TOP )
                                l.c.Category:SetExpanded( false )

                                for kk,vv in pairs(OAWC.Charactersystem.Source.Characters[k]) do
                                    l.c.Button = vgui.Create("DButton", l.c.Category);
                                    l.c.Button:Dock(TOP);
                                    l.c.Button:DockMargin(0,5,0,0);
                                    l.c.Button:SetTall(ScrH()*0.02);
                                    l.c.Button:SetText(vv.name);
                                    l.c.Button.ID = tostring(vv.ID);
                                    l.c.Button.SID = tostring(vv.sid);

                                    l.c.Button.DoClick = function()
                                        l.c.Right:Clear();
                                        local d = {
                                            {
                                                o = 1,
                                                p = "ID: ",
                                                s = vv.ID,
                                                t = false,
                                            },
                                            {
                                                o = 2,
                                                p = "Name: ",
                                                s = vv.name,
                                                t = true,
                                            },
                                            {
                                                o = 4,
                                                p = "Job Kind: ",
                                                s = vv.jobkind,
                                                t = false,
                                            },
                                            {
                                                o = 3,
                                                p = "Gender: ",
                                                s = tostring(vv.other.Gender),
                                                t = false,
                                            },
                                        };

                                        for _k,_v in SortedPairsByMemberValue(d, "o", false ) do
                                            local pnl = vgui.Create("DPanel", l.c.Right);
                                            pnl:Dock(TOP);
                                            pnl:DockMargin(5,5,5,0);
                                            pnl:SetTall(ScrH()*0.03);

                                            local lbl = vgui.Create("DLabel", pnl);
                                            lbl:Dock(LEFT);
                                            lbl:DockMargin(5,0,5,0);
                                            lbl:SetWide(ScrW()*0.09);
                                            lbl:SetText(_v.p);
                                            lbl:SetTextColor(Color(0,0,0,255));

                                            if _v.t == true then
                                                local s = vgui.Create("DButton", pnl);
                                                s:Dock(RIGHT);
                                                s:DockMargin(5,0,0,0);
                                                s:SetWide(ScrW()*0.05);
                                                s:SetText("S A V E");

                                                local lbt = vgui.Create("DTextEntry", pnl);
                                                lbt:Dock(RIGHT);
                                                lbt:SetWide(ScrW()*0.1);
                                                lbt:SetText(_v.s);

                                                s.DoClick = function()
                                                    net.Start("OAWC.CharSys.UpdateName");
                                                    net.WriteInt(vv.ID, 32);
                                                    net.WriteString(lbt:GetText());
                                                    net.SendToServer();
                                                    l.c.scroll:Clear();
                                                    l.c.search:Remove()
                                                    ccp();
                                                end;
                                            else
                                                lbl:SetText(_v.p .. _v.s);
                                            end;
                                        end;
                                    end;
                                    table.insert(ce, l.c.Button);
                                end
                            end;
                        end;

                        l.c.search = vgui.Create("DTextEntry", l.c.leftPanel);
                        l.c.search:Dock(BOTTOM);
                        l.c.search:DockMargin(5,5,5,5);
                        l.c.search:SetPlaceholderText("Search...");

                        function l.c.search:OnChange()
                            local search_text = self:GetText():lower();
                            if (#search_text == 0) then
                                for _,v in pairs(ce) do
                                    v:SetTall(ScrH()*0.02);
                                end;
                            else
                                for _,v in pairs(ce) do
                                    if (v:GetText():lower():find(search_text,1,true) or v.ID:lower():find(search_text,1,true) or v.SID:lower():find(search_text,1,true) ) then
                                        v:SetTall(ScrH()*0.02);
                                    else
                                        v:SetTall(0);
                                    end;
                                end;
                            end;
                        end;
                    end)
                end;
            ccp();
    else
        return;
    end;
end;



concommand.Add("oawc_config", OAWC.UI.OpenConfig);

