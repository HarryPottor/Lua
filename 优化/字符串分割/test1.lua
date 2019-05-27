local table_insert =table.insert
local string_format =string.format


local str1 = "1+2+3+4+5+6+7+s"

function string:splitEx(sep)
	local sep, fields = sep or ",", {}
	self:gsub("([^".. sep.."]+)", function(c) table_insert(fields, c) end)
	return fields
end

local now = os.clock()
print("=================1==================",  now) -- 0.003
for i = 1, 10000* 100 do
   str1:splitEx("+")
end
print("=================2==================", os.clock() - now) -- 5.201
for k, v in pairs(str1:splitEx("+"))do
	print("---------------",k,v)
end
