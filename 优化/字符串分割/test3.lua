local table_insert =table.insert
local string_format =string.format
local string_gsub = string.gsub


local str1 = "1+2+3+4+5+6+7+s"

function string.split(str, delimiter)
    local result = {}
	local delimiter = delimiter or ","
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        table_insert(result, match)
    end
    return result
end

local now = os.clock()
print("=================1==================",  now) -- 0.002
for i = 1, 10000* 100 do
   string.split(str1,"+")
end
print("=================2==================", os.clock() - now) -- 4.82
for k, v in pairs(string.split(str1,"+"))do
	print("---------------",k,v)
end

