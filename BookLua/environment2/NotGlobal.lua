Desc = [[
    每个函数啊允许拥有一个自己的环境来查找全局变量
    setfenv(func/1/2, newenv) 改变一个函数的环境
]]


--[[
a = 1;
setfenv(1, {});
--将全局设置为 空表， print 不在空表内，所以没有
print(a);
--]]

Desc = [[
    如果想在新环境中使用_G,用一下方法
]]
--[[
a = 1;
setfenv(1, {g = _G})
-- g为原来的全局table
g.print(a)
g.print(g.a)

b =2;
g.print(b)
--]]

Desc = [[
    另一种方法：设置 __index
    _G依旧是全局环境
    设置完后 所有的全局变量都在新环境表中
]]

a = 1;
local newgt = {};
setmetatable(newgt, {__index = _G});
setfenv(1, newgt);
print(a)

a = 10;
print(a)
print(_G.a)

Desc = [[
    创建出来的闭包函数 会继承相同的环境，
        如果环境改变了，则闭包函数中调用的环境变量也变了。
]]

a = 100;
function factory()
    return function()
        return a;
    end
end

f1 = factory();
f2 = factory();

print(f1())
print(f2())

setfenv(f1, {a = 200})

print(f1()) -- 200
print(f2()) -- 100
