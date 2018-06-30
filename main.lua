local gui = require('GUI')
local color = require('color')
local component = require('component')

local mainContainer = gui.fullScreenContainer()
local RGB = color.RGBToInteger
local bar = gui.progressBar(160 / 2 - 40 , 20, 80, RGB(255, 255, 255), RGB(0, 0, 0), RGB(0, 0, 255), 0)

mainContainer:addChild(bar)

local percent = 100 * getTotalMemory() / ( getTotalMemory() + getUsedMemory() )

print('Initializing... [Mem Used: ' .. percent .. ']')

mainContainer:drawOnScreen(true)
mainContainer:startEventHandling()

for i = 1, 5 do
	local perc = 100 * 5 / (5 + i)
	bar.value = perc
end