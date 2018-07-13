local component = require('component')

local iHandler = {
	enabled = component.isAvailable('internet')
}

if iHandler.enabled then
	iHandler.internet = require('internet')
	iHandler.iCard = component.getPrimary('internet')
end

return iHandler