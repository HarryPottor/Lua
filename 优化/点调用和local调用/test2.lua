_G.__config = {fTest = {},}

__config.fTest = {
	["s1"] = 1,
	["s2"] = 2,
}


local s_tTest = __config.fTest
_G.fTest1 = function()
	return s_tTest.s1
end

local now = os.clock()
print("=================1==================",  now) -- 0.001
for i = 1, 10000* 1000 do
   fTest1()
end
print("=================2==================", os.clock() - now) -- 1.022