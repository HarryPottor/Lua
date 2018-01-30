local SystemManager = require "Module.System.SystemManager"
-- 创建模块
local M;
module(..., package.seeall)
M = __getModule(...);
M.__index = M
setmetatable(M, SystemManager);
M.__metatable = tostring(SystemManager);

function M:Init()
    local UILogin = require "Module.UI.Login.UILogin";

    SystemManager.Init(self, UILogin:Create());
end

function M:show()
    self.objUI:showUI();
end

function M:hide()
    self.objUI:hideUI();
end

