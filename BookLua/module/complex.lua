-- 原版
--[[
complex = {}

function complex.new(r, i)
    return {r = r, i = i};
end

complex.i = complex.new(0,1);

function complex.add(c1,c2)
    return complex.new(c1.r + c2.r, c1.i + c2.i);
end

return complex;
--]]

--[[
--可以使用一局部变量M
local M = {}
complex = M

function M.new(r, i)
    return {r = r, i = i};
end

M.i = M.new(0,1);

function M.add(c1,c2)
    return M.new(c1.r + c2.r, c1.i + c2.i);
end

return complex;
--]]


--可以省略模块名, 因为require将模块名传给了函数

local modname = ...
local M = {}
_G[modname] = M;

function M.new(r, i)
    return {r = r, i = i};
end

M.i = M.new(0,1);

function M.add(c1,c2)
    return M.new(c1.r + c2.r, c1.i + c2.i);
end


--可以消除 return
-- return M;
package.loaded[modname] = M;