local gui = require('GUI')
local color = require('color')
local component = require('component')

local converter = require('OCOS/lib/memoryConverter')

local mainContainer = gui.fullScreenContainer()
local RGB = color.RGBToInteger

mainContainer:addChild(gui.progressBar(160 / 2 - 40 , 20, 80, RGB(255, 255, 255), RGB(0, 0, 0), RGB(0, 0, 255), 25))
mainContainer:startEventHandling()

print('Initializing... [Mem Used: ' .. converter(getUsedMemory()) .. ' - Max Mem: ' .. converter(getTotalMemory()) .. ']')
