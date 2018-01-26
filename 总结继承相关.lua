DESC= [[
     1 使用metatable设置的父类，如果修改了父类中的变量，则所有该父类生成的子类 的父类部分的变量全变了。
     2 设置父类变量的写法: parent.func(self, ... )

     3  setmetatable只设置了新table的func，在新table中通过self.xxx 可以访问mt中的变量，但一旦在新table中设置了self.xxx = 0 则新table中将拥有xxx变量，
]]


TEST1 = [[------------------------------------------------------------]]
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

TEST2 = [[------------------------------------------------------------]]

require "Class"

Base = NewClass("Base");

function Base:Init(name, age)
    self.name = name;
    self.age = age;
end


Base = require "Base"

UIBase = NewClass("UIBase", Base);

function UIBase:Init(uiname, age)
    -- 这里设置父类中的变量，其实归根结底 是在self中添加了两个变量
    Base.Init(self, uiname, age);
    self.data = 0;
end


TEST2 = [[------------------------------------------------------------]]

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
-- 刚创建出来的时候，obj中只有mt中的方法
for k,v in pairs(obj) do
    print(k,v)
end

-- 这是访问 self.num 是 mt中的num
obj:show();
-- 在obj中 设置了 self.num， 则obj中有了自己的self.num 不再使用mt中的了

obj:setnum(90);

for k,v in pairs(obj) do
    print(k,v)
end