local gui = require('GUI')
local color = require('color')
local component = require('component')
local term = require('term')

local RGB = color.RGBToInteger

local mainContainer = gui.fullScreenContainer()

mainContainer:addChild(gui.panel(1, 1, mainContainer.width, mainContainer.height, 0x2D2D2D))

local bar = mainContainer:addChild(gui.progressBar((mainContainer.width / 2) - 40 , mainContainer.height - 5, 80, 0x3366CC, 0xEEEEEE, 0xEEEEEE, 0, true, true, "Percentage: "))

local percent = 100 * getTotalMemory() / ( getTotalMemory() + getUsedMemory() )

term.clear()
mainContainer:drawOnScreen()

coroutine.wrap(function()
	local perc = 0
	for i = 1, 5 do
		perc = perc + (100 / 5)
		os.sleep(1)
		bar.value = perc
		mainContainer:drawOnScreen()
		if i == 5 then
			os.sleep(2)
			term.clear()
			mainContainer:addChild(gui.panel(1, 1, mainContainer.width, mainContainer.height, 0x00000000))
			mainContainer:drawOnScreen()
			os.exit()
		end
	end
end)()