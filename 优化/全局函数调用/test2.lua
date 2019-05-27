_G.__config = {}
local s_config = _G.__config
--- 创建新的config
function _G.__newconfig(sName)
	local c = __config[sName]
	if not c then
		c = {}
		__config[sName] = c
	end
	return c
end

--- 查找配置
function _G.__findconfig(sName)
	return __config[sName]
end

local __newconfig = __newconfig
local __findconfig = __findconfig
_G.fTest1 = function()
	local n = 0
	for i = 1, 100 do
		n = n + 1
		__newconfig("s"..n)
	end
end

_G.fTest2 = function()
	local n = 0
	for i = 1, 100 do
		n = n + 1
		__findconfig("s"..n)
	end
end

-- local now = os.clock()
-- print("=================1==================",  now) -- 0.002
-- for i = 1, 10000 do
--    fTest1()
--    fTest2()
-- end
-- print("=================2==================", os.clock() - now) --2.327