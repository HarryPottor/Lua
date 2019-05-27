dofile "./test2.lua"
local now = os.clock()
print("=================1==================",  now) -- 0.002
for i = 1, 10000 do
   fTest1()
   fTest2()
end
print("=================2==================", os.clock() - now) --2.327