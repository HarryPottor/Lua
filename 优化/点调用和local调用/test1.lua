_G.__config = {fTest = {},}

__config.fTest = {
	["s1"] = 1,
	["s2"] = 2,
}

_G.fTest1 = function()
	return  __config.fTest.s1
end

local now = os.clock()
print("=================1==================",  now) -- 0.002
for i = 1, 10000* 1000 do
   fTest1()
end
print("=================2==================", os.clock() - now) -- 1.818

-- local 比 直接点调用 为 1：1.8