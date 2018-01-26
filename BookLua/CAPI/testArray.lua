--[[
require "myarray"

a = myarray.mynewarray(1000);
print(a)
print(myarray.mygetarraysize(a))

for i=1, 1000 do
    myarray.mysetarray(a, i, i % 5 == 0);
end

for i=1, 10 do
    print(myarray.mygetarray(a, i));
end

--]]

Desc = [[
    变成对象的方法一:
]]
require "myarray"

local a = myarray.mynewarray(1000);

tab = getmetatable(a)

tab.__index = tab;
tab.set = myarray.mysetarray
tab.get = myarray.mygetarray
tab.size = myarray.mygetarraysize

print(a:size())
print("---------------------------------")
require "array"

local a = array.new(100);

-- local m = getmetatable(a)
-- print(m)
-- for k,v in pairs(m) do
--     print(k,v)
-- end

-- print(m.size(a))
-- m.set(a, 2, true)
-- print(m.get(a, 2))
-- print(m.__tostring(a))
-- print(a.size(a))

a[10] = true;
print(a[10])
print(#a)

for k,v in pairs(getmetatable(a)) do
    print(k,v)
end


print(a:getvalue(tonumber(10)))
print(a:get(tonumber(10)))
