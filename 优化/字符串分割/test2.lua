local string_find = string.find
local string_len = string.len
local string_sub = string.sub

local str2 = "1+2+3+4+5+6+7+s"
function string.split(srcstr, delimiter)
	if type(srcstr) ~= "string" then
		assert(false, "srcstr need string")
	end
	local delimiter = delimiter or ","
	local len = string_len(srcstr)
	local itr, index = 1, 1
	local array = {}
	while true do
		local beginpos, endpos = string_find(srcstr, delimiter, itr)
		if not beginpos then
			array[index] = string_sub(srcstr, itr, len)
			break
		end
		array[index] = string_sub(srcstr, itr, beginpos - 1)
		itr = endpos + 1
		index = index + 1
	end
	return array
end

function string:splitEx(sep)
	local sep, fields = sep or ",", {}
	local pattern = string_format("([^%s]+)", sep)
	self:gsub(pattern, function(c) table_insert(fields, c) end)
	return fields
end

local now = os.clock()
print("=================3==================",  now) -- 0.002
for i = 1, 10000* 100 do
    string.split(str2,"+")
end
print("=================4==================", os.clock() - now) -- 5.964
for k, v in pairs(string.split(str2,"+"))do
    print("---------------",k,v)
end

