local strs = {};
for i = 1, 3 do
    strs[i] = "helloworld";
end

local result = "";

local now = os.clock()
print("=================1==================",  now) -- 0.004
for i = 1, 10000 do
	result = result..table.concat(strs)
end
print("=================2==================", result,os.clock() - now) -- 0.004

