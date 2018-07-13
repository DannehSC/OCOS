--FILE = SITE

local fileManifest = {
	--Boot
	["/OCOS/boot/kernel.lua"] = "https://raw.githubusercontent.com/DannehSC/OCOS/master/OCOS/boot/kernel.lua",
	["/OCOS/boot/main.lua"] = "https://raw.githubusercontent.com/DannehSC/OCOS/master/OCOS/boot/main.lua",
	--Lib
	["/OCOS/lib/authentication.lua"] = "https://raw.githubusercontent.com/DannehSC/OCOS/master/OCOS/lib/authentication.lua",
	["/OCOS/lib/internetHandler.lua"] = "https://raw.githubusercontent.com/DannehSC/OCOS/master/OCOS/lib/internetHandler.lua",
	["/OCOS/lib/logger.lua"] = "https://raw.githubusercontent.com/DannehSC/OCOS/master/OCOS/lib/logger.lua",
	["/OCOS/lib/sha256.lua"] = "https://raw.githubusercontent.com/DannehSC/OCOS/master/OCOS/lib/sha256.lua",
}

return fileManifest
