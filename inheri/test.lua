-- window = {}
-- window.property = {x=0; y = 0; width = 100; height = 100}

-- mt = {}

-- function window.new( obj )
--     setmetatable(obj, mt);
--     return obj
-- end
-- mt.__index = window.property;
-- mt.__add = function (win1, win2)
--     local res = {x = win1.x+ win2.x; y=win1.y+win2.y};
--     return res;
-- end
-- local obj = window.new{x = 10, y=20};
-- local obj2 = window.new{x = 10, y=20};
-- local res = obj+obj2;
-- print(res.x)

mt = {name="", age=0}
mt.__index = mt;
mt.__add = function (a, b)
    return {name = a.name .. b.name; age = a.age+b.age};
end

obj = {}
setmetatable(obj, mt);
obj.name = "lily";
obj.age = 10;

obj2 = {}
setmetatable(obj2, mt)
obj2.name = "lily";
obj2.age = 20;

local res = obj + obj2;

print(res.name, res.age)
