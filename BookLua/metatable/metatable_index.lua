IndexDesc = [[
    rawget(tab, i) 从原始表获取数据，不考虑元表；而且 i 是数字下标。
    rawset(tab, k, v) 不设置元表，只设置tab中的数据.

    当设置的值既不是table中的原始数据，也不是元表中的数据，且__newindex
        有设置，则会直接在__newindex的表中设置数据。后来新建的数据都会有该值
    
    可以通过 __index = function ()
            return d;
        end
    设置默认值
]]


window = {}

window.property = {x= 0; y = 0; width = 100; height = 100; "ABC"};
window.mt = {};
function window.new(obj)
    setmetatable(obj, window.mt);
    return obj;
end

-- window.mt.__index = function (tab, key)
--     return window.property[key];
-- end
window.mt.__index = window.property;
window.mt.__newindex = window.property;

local win = window.new({x = 10, y = 10, });
print(win.width)
print(win.x)
print(win[1])

print(rawget(win, width))
print(rawget(win, 1))   ---"abc"

tab = {x = 10, y = 20};
print(rawget(tab, x))   ---"nil"
win.z = 400;

local win2 = window.new{x = 100, y=100};
print(win2.z)

print("-----------------------------------------")
function setdefault(tab, num)
    local mt = {__index = function ()
        return num;
    end}
    setmetatable(tab, mt)
end

tab = {x=10, y=20};
print (tab.x, tab.z);
setdefault(tab, 0);
print (tab.x, tab.z);
tab2 = {x=10, y=20};
setdefault(tab2, 90);
print(tab2.z)