local string_format = string.format
local strs = {};
for i = 1, 3 do
    strs[i] = "helloworld%s";
end

local result = "";

local now = os.clock()
print("=================1==================",  now) -- 0.004
for i = 1, 10000 do
    for index, str in ipairs(strs) do
        result = string_format(str,result)
    end
end
print("=================2==================",result, os.clock() - now) -- 1.282