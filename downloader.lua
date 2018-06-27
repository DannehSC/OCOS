local component = require('component')

if not component.isAvailable('internet') then
	error('No internet available. Cannot download.')
end

local fs = require('filesystem')
local internet = require('internet')

local manifestURL = "https://raw.githubusercontent.com/DannehSC/OCOS/master/downloadmanifest.lua"

print('Checking manifest for updates.')
local manData = ""
for dat in internet.request(manifestURL) do
	manData = manData .. tostring(dat)
end
if io.open('./downloadmanifest.lua', 'r'):read('*a') ~= manData then
	print('Updating manifest')
	local file = io.open('./downloadmanifest.lua', 'w')
	file:write(manData)
	file:close()
else
	error('[ERROR] Unable to fetch manifest.')
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
