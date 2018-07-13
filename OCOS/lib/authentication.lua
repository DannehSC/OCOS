local sha = require('./sha256.lua')

local authentication = {}

return setmetatable(authentication, {
	__newindex = function() error('No new values.') end,
	__metatable = 'Locked'
})