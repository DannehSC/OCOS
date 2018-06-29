local component = require('component')

if not component.isAvailable('internet') then
	error('No internet available. Cannot download.')
end

local fs = require('filesystem')
local shell = require('shell')
local computer = require('computer')
local internet = require('internet')

if not pcall(require, 'gui') then
	print('Installing GUI library.')
	
	local installer = "https://pastebin.com/raw/ryhyXUKZ"
	local data = ''
	
	for dat in internet.request(installer) do
		data = data .. tostring(dat)
	end
	
	local file = io.open('./GUIInstaller.lua', 'w')
	file:write(data)
	file:close()
	
	shell.execute('./GUIInstaller.lua')
	
	fs.remove('./GUIInstaller.lua')
	
	print('GUI library installed. Credits to IgorTimofeev on GitHub.')
end

local manifestURL = "https://raw.githubusercontent.com/DannehSC/OCOS/master/downloadmanifest.lua"

print('Checking manifest for updates.')
	

local manData = ""

for dat in internet.request(manifestURL) do
	manData = manData .. tostring(dat)
end
if not manData then
	error('[ERROR] Unable to fetch manifest.')
end

local u = true

if fs.exists('./downloadmanifest.lua') then
	if io.open('./downloadmanifest.lua', 'r'):read('*a') ~= manData then
		print('Updating manifest')
	else
		print('Manifest up to date.')
		u = false
	end
else
	print('Installing manifest')
end

if u then
	local file = io.open('./downloadmanifest.lua', 'w')
	file:write(manData)
	file:close()
end

local manifest = require('downloadmanifest')

for i, v in pairs(manifest) do
	local data = ""
	for dat in internet.request(v) do
		data = data .. tostring(dat)
	end
	if data then
		local u = true
		if fs.exists('./' .. i) then
			if io.open('./' .. i, 'r'):read('*a') ~= data then
				print('Updating ' .. i)
			else
				print('Ignoring ' .. i .. ' - It is already updated')
				u = false
			end
		else
			print('Installing ' .. i)
		end
		if u then
			local file = io.open('./' .. i, 'w')
			file:write(data)
			file:close()
		end
	else
		print('[WARNING] Unable to request ' .. v)
	end
end

print('Rebooting to finish updates...')

os.sleep(2)

computer.shutdown(true)
