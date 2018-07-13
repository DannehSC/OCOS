--FILE = SITE

local fileManifest = {
	--Boot
	["/OCOS/boot/kernel.lua"] = "https://raw.githubusercontent.com/DannehSC/OCOS/master/kernel.lua",
	["/OCOS/boot/main.lua"] = "https://raw.githubusercontent.com/DannehSC/OCOS/master/main.lua",
	--Lib
	["/OCOS/lib/authentication.lua"] = "",
	["/OCOS/lib/internetHandler.lua"] = "https://raw.githubusercontent.com/DannehSC/OCOS/master/internetHandler.lua",
	["/OCOS/lib/logger.lua"] = "https://raw.githubusercontent.com/DannehSC/OCOS/master/logger.lua",
	["/OCOS/lib/sha256.lua"] = "",
}

return fileManifest