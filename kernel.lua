--L. Kernel

local function kPanic(...)
	error('[!KERNEL PANIC!]', ...)
end

local function hError(...)
	error('[ERROR]', ...)
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

local logger = checkReq('./logger.lua')
local internet = checkReq('./internetHandler.lua')

local startScript, startSandboxed

_G.sandboxed = {}

function startScript(path)
	if fs.exists(path) then
		local file = io.open(path, 'r')
		local data = file:read('*a')
		local loaded, err = load(data)
		if loaded then
			local env = getfenv(loaded)
			function env.getUsedMemory()
				return computer.totalMemory() - computer.freeMemory()
			end
			function env.getFreeMemory()
				return computer.freeMemory()
			end
			function env.getTotalMemory()
				return computer.totalMemory()
			end
			function env.startScript(...)
				startScript(...)
			end
			function env.startSandboxed(...)
				startSandboxed(...)
			end
			function env.error(...)
				logger:err(...)
			end
			function env.shutdown(reboot)
				computer.shutdown(reboot)
			end
			env.hError = hError
			if internet.enabled then
				env.internet = internet
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
			local loaded, err = load(data)
			if loaded then
				local env = getfenv(loaded)
				function env.getUsedMemory()
					return computer.totalMemory() - computer.freeMemory()
				end
				function env.getFreeMemory()
					return computer.freeMemory()
				end
				function env.getTotalMemory()
					return computer.totalMemory()
				end
				function env.require(path, ...)
					startSandboxed(path, false, ...)
				end
				if admin then	
					function env.shutdown(reboot)
						computer.shutdown(reboot)
					end
				end
				env._G = _G.sandboxed
				local ran, er = pcall(loaded)
				if er then
					error(er)
				end
			else
				error(err)
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