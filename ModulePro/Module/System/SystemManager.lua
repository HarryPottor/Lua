local Base = require "Core.Base"
local UIManager = require "Module.UI.UIManager"

local M;
-- 创建模块
module(..., package.seeall)
M = __getModule(...);
M.__index = M
setmetatable(M, Base);
M.__metatable = tostring(Base);

function M:Init(uiobj)
    print("-----------------------")
    print(debug.traceback())
    self.objUI = uiobj;
end

function M:SendToServer()
    print("Send:", self.objUI:GetName(), self.objUI:GetInfo(), 
        self.objUI:GetValue());
end

