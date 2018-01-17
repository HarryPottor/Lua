Desc = [[
    使用环境 将模块中的函数放入环境中，这样对所有的函数来说都是可见的
        且不会污染全局表 
    缺点在于引入_G 的数据，有几个方法可以实现:
]]

local modname = ...;
local M = {}
_G[modname] = M;
package.loaded[modname] = M;

--方法1 使用继承
-- 缺点，环境中包含了_G 的全局变量。会出现这样的调用:modname.math.sin()
--setmetatable(M, {__index = _G})

--方法2 创建局部变量
-- 缺点，同上，但稍快，因为不涉及元方法，但使用时要加 _G.
--local _G = _G;

-- 方法3 将需要的函数 提前加入
local Tool = require "tool"
local print = _G.print;
local io = _G.io;

setfenv(1, M)

function new(r, i)
    return {r = r, i = i}
end

i = new(1, 2);

function add(a, b)
    return new(a.r+ b.r, a.i + b.i);
end

function show(a)
    Tool.showTable(a);
end

