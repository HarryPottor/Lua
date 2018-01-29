
local Class = require "Core.Class"

local M;
-- 创建模块
module(..., package.seeall)
M = __getModule(...);
M.__index = M
setmetatable(M, Class);
M.__metatable = tostring(Class);

function M:Create(...)
    print("Create------------------")
    local newobj = setmetatable({}, self);
    newobj:Init(...);
    return newobj;
end

function M:Init(name)
    print("Init------------------")
    self.name = name;
end

function M:ShowName()
    return print(self.name);
end