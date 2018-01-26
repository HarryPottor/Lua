
function createModule(modname)
    print("-----------------", modname)
    local M = {}
    _G[modname] = M;
    package.loaded[modname] = M;
    setmetatable(M, {__index = _G})
    setfenv(2, M);
end

-- local mod = require "TestModule"
-- mod:showinfo(10, 12)

local newmod = require "mods.NewModule"
newmod:showinfo(101, 121)
for k,v in pairs(_G) do
    print(k,v)
end



-- require "UIBase"
-- object = UIBase.Create(10, 20);
-- object2 = UIBase.Create(100, 200);
-- object:showPos()
-- object:showName()
-- object2:showPos()
-- object2:showName()

-- for k,v in pairs(object) do
--     print(k,v)
-- end
