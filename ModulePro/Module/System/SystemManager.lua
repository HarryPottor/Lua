local Base = require "Core.Base"
local UIManager = require "Module.UI.UIManager"

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

function Init(obj, uiobj)
    print("-----------------------")
    print(debug.traceback())
    obj.objUI = uiobj;
end

function SendToServer(obj)
    print("Send:", obj.objUI:GetName(), obj.objUI:GetInfo(), 
        obj.objUI:GetValue());
end

