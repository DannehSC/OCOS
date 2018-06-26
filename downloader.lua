local component = require('component')

if not component.isAvailable('internet') then
	error('No internet available. Cannot download.')
end

local fs = require('filesystem')
local internet = require('internet')

local manifestURL = "https://raw.githubusercontent.com/DannehSC/OCOS/master/downloadmanifest.lua"

if not fs.exists('./downloadmanifest.lua') then
	print('Attempting to download manifest.')
	local manData = ""
	for dat in internet.request(manifestURL) do
		manData = manData .. tostring(dat)
	end
	if manData then
		local file = io.open('./downloadmanifest.lua', 'w')
		file:write(manData)
		print(manData)
		file:close()
	else
		error('[ERROR] Unable to fetch manifest.')
	end
end

local manifest = require('downloadmanifest')

print(manifest)

for i, v in pairs(manifest) do
	print('Downloading: ' .. i)
	local data = ""
	for dat in internet.request(v) do
		data = data .. tostring(dat)
	end
	if data then
		local file = io.open('./' .. i, 'w')
		file:write(data)
		file:close()
	else
		print('[WARNING] Unable to request ' .. v)
	end
end
