
local Class = require "Core.Class"

local M = __getModule(...);
if  M ~= nil then
    return M; 
end
-- 创建模块
module(..., package.seeall)
M = __getModule(...);
M.__index = M
setmetatable(M, Class);
M.__metatable = tostring(Class);

function Create(obj, ...)
    print("Create------------------")
    local newobj = setmetatable({}, obj);
    newobj:Init(...);
    return newobj;
end

function Init(obj, name)
    print("Init------------------")
    obj.name = name;
end

function ShowName(obj)
    return print(obj.name);
end