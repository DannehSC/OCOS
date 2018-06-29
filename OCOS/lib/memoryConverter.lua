local modf, fmod = math.modf, math.fmod

local MB_PER_GB = 1024
local KB_PER_MB = 1024
local B_PER_KB = 1024

local B_PER_MB = B_PER_KB * KB_PER_MB
local B_PER_GB = B_PER_MB * MB_PER_GB

local memfmt = '%s GB %s MB %s KB %s B'
local function getMem(value)
	local mem = value * B_PER_KB

	return memfmt:format(modf(mem / B_PER_GB), modf(fmod(mem / B_PER_MB, MB_PER_GB)), modf(fmod(mem / B_PER_KB, KB_PER_MB)), modf(fmod(mem, B_PER_KB)))
end

return getMem