local mt = {
    name = "mt";
}
mt.__index = mt;
local tab = setmetatable({}, mt);
mt.__metatable = tostring(mt)
print(tab.name)

function tab:SetName(name)
    self.name = name
end
tab:SetName("Lucy")
print(tab.name)
