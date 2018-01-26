local Base = require "Core.Base";
local M = __getModule(...);
if  M ~= nil then
    return M; 
end
-- 创建模块
module(..., package.seeall)
M = __getModule(...);
M.__index = M
setmetatable(M, Base);
M.__metatable = tostring(Base);

function Init(obj)
    print("===================")
    obj.name = "";
    obj.info = "";
    obj.value = 0;
end

function SetData(obj, name, info, value)
    obj.name = name;
    obj.info = info;
    obj.value = value;
end

function GetName(obj)
    return obj.name;
end

function GetInfo(obj)
    return obj.info;
end

function GetValue(obj)
    return obj.value;
end
