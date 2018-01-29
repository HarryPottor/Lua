Info = [[
    1 首先明确一点，模块是可以用module 创建的。使用module创建的模块没有元表，因此可以在使用setmatatable创建元表。
    2 使用module创建模块的方法 不能 存放在别的文件的方法中，环境不能起到作用。
    3 多次require只会 执行一遍，因为在package.loaded 表中进行了保存。
    4 元表设置 __metatable 变量后，元表中的值不能修改。
    5 与C++ 中的类 有所区别的 地方在于：lua中的类是个table是可以修改其中的值的，然而C++中的类仅仅是个模板，创建对象的模板.所以用 module 创建的模块应该像C++那样去使用，创建出对象，在去调用对象去实现一些功能，而不是像原来直接拿着类名去操作
    6 module中方法都是.出来的方法，所以需要在前边添加上obj, func(obj, ...);
        或者 M:func(...)
    7 因为是module ，是个类，所以它能做别人的元表，所以需要设置上__index 变量
]]

function __getModule(name)
    local M = _G;
    for value in string.gmatch(name, "%w+") do
        M = M[value]
        if  M == nil then
            return nil;
        end
    end
    if  M == _G then
        return nil;
    else
        return M;
    end
end


local Class = require "Core.Class"

local M;
-- 创建模块
module(..., package.seeall)
M = __getModule(...);
M.__index = M
setmetatable(M, Class);
Class.__metatable = tostring(Class);

function Create(obj, ...)
    local newobj = setmetatable({}, obj);
    newobj:Init(...);
    return newobj;
end

或者 

function M:Create( ...)
    local newobj = setmetatable({}, self);
    newobj:Init(...);
    return newobj;
end