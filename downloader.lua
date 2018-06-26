if not component.isAvailable('internet') then
	error('No internet available. Cannot download.')
end

local internet = require('internet')
local file_sys = require('filesystem')
local manifest = require('./downloadmanifest.lua')

for i, v in pairs(manifest) do
	local data = internet.request(v)
	if data then
		
	else
		print('[WARNING] Unable to request ' .. v)
	end
end