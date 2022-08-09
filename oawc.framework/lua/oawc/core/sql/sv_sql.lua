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
require("mysqloo")

local SQL = {}



concommand.Add("SQL.DeleteTable", function(ply,_,args)
	OAWC.SQL:Query("DROP TABLE IF EXISTS `".. args[1] .."`")
end)
--[[---------------------------------------------------------
	Name: Setup
-----------------------------------------------------------]]
SQL.config = {}
SQL.config = {
	mysql = OAWC.Config.SQL.UseMySQL or false,
	host = OAWC.Config.SQL.HostIP or "",
	username = OAWC.Config.SQL.Username or "",
	password = OAWC.Config.SQL.Password or "",
	schema = OAWC.Config.SQL.Databasename or "",
	port = OAWC.Config.SQL.Port or 3306
}

--[[---------------------------------------------------------
	Name: Functions
-----------------------------------------------------------]]
function SQL.Constructor(self, config)
	local sql = {}

	config = config or {}

	sql.config = {
		mysql = OAWC.Config.SQL.UseMySQL or false,
		host = OAWC.Config.SQL.HostIP or "",
		username = OAWC.Config.SQL.Username or "",
		password = OAWC.Config.SQL.Password or "",
		schema = OAWC.Config.SQL.Databasename or "",
		port = OAWC.Config.SQL.Port or 3306
	}

	mysqloo.onConnected = function() end
	sql.cache = {}

	setmetatable(sql, SQL)

	sql:RequireModule()

	return sql
end

local function querymysql(self, query, callback, errorCallback)
	if not query or not self.db then return end

	local q = self.db:query(query)

	function q:onSuccess(data)
		if callback then
			callback(data)
		end
	end

	function q:onError(_, err)
		if not self.db or self.db:status() == mysqlOO.DATABASE_NOT_CONNECTED then
			table.insert(self.cache, {
				query = query,
				callback = callback,
				errorCallback = errorCallback
			})

			mysqloo:Connect(self.config.host, self.config.username, self.config.password, self.config.schema, self.config.port)

			return
		end

		if errorCallback then
			errorCallback(err)
		end
	end

	q:start()
end

local function querySQLite(self, query, callback, errorCallback)
	if not query then return end

	sql.m_strError = ""

	local lastError = sql.LastError()
	local result = sql.Query(query)

	if sql.LastError() and sql.LastError() != lastError then
			local err = sql.LastError()

			if errorCallback then
				errorCallback(err, query)
			end

			return
	end

	if callback then
		callback(result)
	end
end

--[[---------------------------------------------------------
	Name: Meta Function
-----------------------------------------------------------]]
function SQL:RequireModule()
	if not self.config.mysql then return end

	if not pcall(require, "mysqloo") then
		error("Couldn't find mysqlOO. Please install https://github.com/FredyH/mysqlOO. Reverting to SQLite")

		self.config.mysql = false
	end
end

function SQL:SetConfig(config)
	if not config or not type(config) == "table" then return end

	self:RequireModule()

	self.config = config
end

function SQL:Connect()
	if self.config.mysql then
		self.db = mysqloo.connect(self.config.host, self.config.username, self.config.password, self.config.schema, self.config.port)

		self.db.onConnectionFailed = function(_, msg)
			timer.Simple(5, function()
				if not self then return end

				self:Connect(self.config.host, self.config.username, self.config.password, self.config.schema, self.config.port)
			end)

			error("Connection failed! " .. tostring(msg) ..	"\nTrying again in 5 seconds.")
		end

		mysqloo.onConnected = function()
			for k, v in pairs(self.cache or {}) do
				self:Query(v.query, v.callback, v.errorCallback)
			end

			self.cache = {}

			mysqloo.onConnected()
		end

		self.db:connect()
	end
end

function SQL:Disconnect()
	if IsValid(self.db) then
		self.db:disconnect()
	end
end

function SQL:Query(query, callback, errorCallback)
	local func = self.config.mysql and querymysql or querySQLite

	func(self, query, callback, errorCallback)
end


function SQL:UsingMySQL()
	print(OAWC.Config.SQL.UseMySQL)
	--return OAWC.Config.SQL.UseMySQL
end

function SQL:Escape(str)
	if self:UsingMySQL() then
		return string.Replace(self.db:escape(tostring(str)), "'", "")
	else
		return string.Replace(sql.SQLStr(str), "'", "")
	end
end

--[[---------------------------------------------------------
	Name: Meta Tables
-----------------------------------------------------------]]
SQL.__index = SQL

setmetatable(SQL, {
	__call = SQL.Constructor
})





if SQL then
	SQL:Disconnect()
end

SQL:Connect()


OAWC.SQL = SQL








