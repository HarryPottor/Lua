
--[[
function foo2( ... )
    print(arg.n, unpack(arg))
    for k,v in ipairs(arg) do
        print(k,v)
    end
end


function foon( ... )
    local s = 0;
    for i,v in ipairs({...}) do
        s = s+ v;
    end
    print("------------------------------")
    for i=1,select('#', ...) do
        print(i, select(i, ...))
    end
    return s;
end
foo2(1,2,3,4)
print(foon(1,2,3, nil))
os.rename("test.lua", "TEST.lua")

--]]

--[[
CreateGuidFunc = function ()
    local index = 0;
    return function ()
        index = index + 1;
        return index;
    end
end

CreateGuid = CreateGuidFunc();
CreateGuid2 = CreateGuidFunc();

for i=1, 10 do
    print(CreateGuid())
    print(CreateGuid2())
end

--]]


--[[
factory = function ()
    local index;
    return function ()
        index = (index or 0) + 1;
        if  index < 10 then
            return index;
        end
    end
end

for v in factory() do
    print(v)
end

function myiter(tab, i)
    i = i + 1;
    local v = tab[i]
    if  v then
        return i, v
    end
end

function func(tab)
    return myiter, tab, 0;
end

for v in func({"1nv","ted", "adf"}) do
    print(v)
end

--]]

--[[
function func(num)
    error("run error", 2);
    return 123,23, num;
end
state, res1, res2 = pcall(func, 100)
if state then
    print("run ok")
else
    print(debug.traceback())
end

--]]


--[[
mt = {}

mt.__eq = function (a,b)
    return a.name == b.name and a.id == b.id;
end

mt.__lt = function(a, b)
    return a.id < b.id
end

mt.__le = function(a, b)
    return a.id <= b.id
end

function create(tab)
    local obj = {}
    setmetatable(obj, mt);
    for k,v in pairs(tab) do
        obj[k] = v
    end
    return obj
end
taba = create{name="lily", id = 1};
tabb = create{name="lucy", id = 2};

print(taba ~= tabb)

--]]

print(package.path)
print(package.cpath)