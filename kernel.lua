--L. Kernel

local realEnv = _ENV

local function kPanic(...)
	error('[!KERNEL PANIC!] ' .. table.concat({...}))
end

local function hError(...)
	error('[ERROR] ' .. table.concat({...}))
end

local function checkReq(path)
	if pcall(require, path) then
		return require(path)
	else
		kPanic('File not found. ['..path..']')
	end
end

local fs = require('filesystem')
local computer = require('computer')

local logger = checkReq('logger')
local internet = checkReq('internetHandler')

local startScript, startSandboxed

_G.sandboxed = {}

function startScript(path)
	if fs.exists(path) then
		local file = io.open(path, 'r')
		local data = file:read('*a')
		local newEnv = setmetatable({}, {
			__index = function(self, index)
				if rawget(self, index) then
					return rawget(self, index)
				elseif realEnv[index] and index ~= '_ENV' then
					return realEnv[index]
				else
					return nil
				end
			end
		})
		local loaded, err = load(data, 'Script', 'bt', newEnv)
		if loaded then
			function newEnv.getUsedMemory()
				return computer.totalMemory() - computer.freeMemory()
			end
			function newEnv.getFreeMemory()
				return computer.freeMemory()
			end
			function newEnv.getTotalMemory()
				return computer.totalMemory()
			end
			function newEnv.startScript(...)
				startScript(...)
			end
			function newEnv.startSandboxed(...)
				startSandboxed(...)
			end
			function newEnv.error(...)
				logger:err(...)
			end
			function newEnv.shutdown(reboot)
				computer.shutdown(reboot)
			end
			newEnv.hError = hError
			if internet.enabled then
				newEnv.internet = internet
			end
			local ran, er = pcall(loaded)
			if er then
				logger:err('startScript [RUNTIME]', er)
			end
		else
			logger:err('startScript [SYNTAX]', err)
		end
	else
		logger:err('startScript [PATH] No file exists at '..path)
	end
end

function startSandboxed(path, admin)
	local a,b = pcall(function()
		if fs.exists(path) then
			local file = io.open(path, 'r')
			local data = file:read('*a')
			local newEnv = setmetatable({}, {
				__index = function(self, index)
					if rawget(self, index) then
						return rawget(self, index)
					elseif realEnv[index] and index ~= '_ENV' then
						return realEnv[index]
					else
						return nil
					end
				end
			})
			local loaded, err = load(data, '[S]Script', 'bt', newEnv)
			if loaded then
				function newEnv.getUsedMemory()
					return computer.totalMemory() - computer.freeMemory()
				end
				function newEnv.getFreeMemory()
					return computer.freeMemory()
				end
				function newEnv.getTotalMemory()
					return computer.totalMemory()
				end
				function newEnv.require(path, ...)
					startSandboxed(path, false, ...)
				end
				if admin then	
					function newEnv.shutdown(reboot)
						computer.shutdown(reboot)
					end
				end
				newEnv._G = _G.sandboxed
				local ran, er = pcall(loaded)
				if er then
					error('[RUNTIME] ' .. er)
				end
			else
				error('[SYNTAX] ' .. err)
			end
		else
			logger:err('[ERROR] No file exists at '..path..' [S]')
		end
	end)
	if not a then
		logger:err('[ERROR] '..b..' [S]')
	end
end

startScript('./main.lua')
