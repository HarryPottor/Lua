local UIManager = require "Module.UI.UIManager";
local M;
-- 创建模块
module(..., package.seeall)
M = __getModule(...);
M.__index = M
setmetatable(M, UIManager);
M.__metatable = tostring(UIManager);

function M:Init()
    M:SetData("UILogin", "This is the first UI", 1)
end

function M:showUI()
    print("Login UI is Show");
end

function M:hideUI( )
    print("Login UI is Hide");
end
