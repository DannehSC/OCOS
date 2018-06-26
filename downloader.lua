local component = require('component')

if not component.isAvailable('internet') then
	error('No internet available. Cannot download.')
end

local fs = require('filesystem')
local internet = require('internet')

local manifestURL = "https://raw.githubusercontent.com/DannehSC/OCOS/master/downloadmanifest.lua"

if not fs.exists('./downloadmanifest.lua') then
	local manData = internet.request(manifestURL)
	if manData then
		local file = io.open('./downloadmanifest.lua', 'w')
		file:write(manData)
		file:close()
	else
		error('[ERROR] Unable to fetch manifest.')
	end
end

local manifest = require('./downloadmanifest.lua')

for i, v in pairs(manifest) do
	local data = internet.request(v)
	if data then
		local file = io.open('./' .. i, 'w')
		file:write(data)
		file:close()
	else
		print('[WARNING] Unable to request ' .. v)
	end
end
