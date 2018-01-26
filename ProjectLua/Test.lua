-- require "Base"

-- obj = Base.Create("harry", 10);
-- obj:ShowSelf()

-- obj2 = Base.Create("lily", 12);
-- obj2:ShowSelf()
-- obj:ShowSelf()


-- require "UIBase"

-- obj = UIBase.Create("Lily", 12)
-- obj:setData(90);
-- obj2 = UIBase.Create("Lucy", 15)
-- obj2:setData(900);

-- obj:ShowSelf()
-- obj2:ShowSelf()

-- print(obj:getData());
-- print(obj2:getData());

-- for k,v in pairs(obj) do
--     print(k,v)
-- end

--[=[

RESULT = [[
    1 使用metatable设置的父类，如果修改了父类中的变量，则所有该父类生成的子类 的父类部分的变量全变了。
]]

    require "Class"

    tab = {num = 0, str = ""}
    NC = NewClass("nc", tab);
    function NC:Init(n,s)
        --!!这里的self 与 NC 不一样, self 是传入的对象， NC则是类本身
        self.str = s;
        self.num = n;
        -- 这里的修改会导致 NC 类的参数发生变化
        -- 所以在类中 一定要使用 self 或者传入对象， 不要对原table进行操作
        NC.str = s;
        NC.num = n;
    end
    function NC:setData(n, s)
        self.str = s;
        self.num = n;
    end
    function NC:showData()
        print(self.num, self.str)
    end
    obj1 = NC.Create(1, "111");

    obj2 = NC.Create(2, "222");

    -- 虽然生成的对象不同，但他们的元表是相同的，一个元表变动了，都跟着变
    mt1 = getmetatable(obj1)
    mt2 = getmetatable(obj2)
    print(mt1, mt2)
    for k,v in pairs(mt1) do
        print(k,v)
    end

    obj1:showData()
    obj2:showData()
    obj1:showData()
]=]


mt = {
    num = 100;
}
mt.__index = mt;

function Create()
    local obj = setmetatable({}, mt);
    function obj:show()
        print(self.num);
    end
    function obj:setnum(num)
        self.num = num;
    end
    return obj
end

obj = Create();
for k,v in pairs(obj) do
    print(k,v)
end

obj:show();
obj:setnum(90);

for k,v in pairs(obj) do
    print(k,v)
end

-- obj:show()
-- obj2 = Create();
-- obj2:show();