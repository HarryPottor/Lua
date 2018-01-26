
--[[
-- 普通的模块
local mod = require "complex"

print(complex.i.r, complex.i.i)
print(type(mod), mod)

local var = mod.new(23,1);
print(var.r, var.i)
--]]

--[[
-- 引入环境的模块
local envmod = require "complex2"

local a = envmod.new(1,2);
local b = envmod.new(3,3);

local c = envmod.add(a, b);
envmod.show(c)
--]]


local funcmod = require "funcmod"
local complex = require "complex2"

for k,v in pairs(funcmod) do
    if type(v) == "table" then
        print("----------------------",k,v)
        for k1,v1 in pairs(v) do
            print(k1,v1)
        end
    end
end

--[[
funcmod.showinfo("abc")
print(complex.i.r, complex.i.i)

funcmod.showtable({"aaa", "bbb"})
]]

print(package.path)

local mymath = require "submode.mymath"
mymath.showname()
for k,v in pairs(mymath) do
    print(k,v)
end