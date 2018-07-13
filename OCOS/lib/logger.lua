local fs = require('filesystem')

local logger = {}

function logger:err(...)
	print(...)
end

return logger