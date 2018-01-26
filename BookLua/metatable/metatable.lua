Set = {}
local mt = {};

function Set.new(list)
    local set = {};
    setmetatable(set, mt);
    for _, v in ipairs(list or {}) do
        set[v] = true;
    end

    return set;
end

function Set.Bing(a, b)
    if getmetatable(a) ~= mt or getmetatable(b) ~= mt then
        error("attempt to 'add' a set with a non-set value", 2);
    end

    local set = Set.new();
    
    for v in pairs(a) do
        set[v] = true;
    end
    for v in pairs(b) do
        set[v] = true;
    end

    return set;
end

function Set.Jiao(a,b)
    local set = Set.new();
    for k in pairs(a) do
        set[k] = b[k];
    end
    return set;
end

function Set.tostring(set )
    local list = {};
    for e, v in pairs(set) do
        list[#list + 1] = e;
    end

    return "{" .. table.concat(list, ", ") .. "}";
end

function Set.print(set)
    print(Set.tostring(set));
end

-- local a = {name = "avc", id = "err", school = "vve"};
-- local b = {name = "bdc", addr = "vva", parent = "err"};


-- Set.print(Set.Bing(a,b));
-- Set.print(Set.Jiao(a,b));

mt.__add = Set.Bing;
mt.__mul = Set.Jiao;



a = Set.new({1,2,3})
b = Set.new({1})

print(getmetatable(a));
print(getmetatable(b));

Set.print(a+b);
Set.print(a*b);

--Set.print(a + 10);

MetatableDesc = [[
    部分有序 ：不是所有的值都能排序.
    NaN 遇到则为false。NaN = 0/0;
    因此当table中有NaN都会出错，所以__le 和 __lt 分别实现。
    关系类元方法: __eq, __le, __lt
    a~=b    =>   not (a==b)
    a >= b  =>   not (b < a)
    a > b   =>   b <= a;

    print 函数打印的东西，回去原表中查找是否有 --tostring 方法，如果有
        则把当前值作为参数传给 __tostring;

    mt.__metatable 变量如果被设置了，在对以mt为原表的table 在设置原表则会报错
        这个字段只是限制更改 table的元表。 

    __index
]]

-- a <= b 代表 a是b的子集，a中的元素b全都有
mt.__le = function (a, b)
    for k in pairs(a) do
        if not b[k] then
            return false;
        end
    end
    return true;
end

mt.__lt = function (a, b)
    return a <= b and not(b <= a)
end

mt.__eq = function (a, b)
    return a <=b and b <= a;
end
mt.__metatable = "not your business";
mt.__tostring = Set.tostring;

--setmetatable(a, {})
print(getmetatable(a))
print(b)