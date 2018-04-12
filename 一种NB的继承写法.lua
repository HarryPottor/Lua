function TablePrint(T, count)
    count = count or 0;
    for k, v in pairs(T) do
        local tab = "";
        for i = 1, count do
            tab = tab .. "\t";
        end
        print(tab .. k .. ":" .. tostring(v));
        if type(v) == "table" and k ~= "__index" then
            TablePrint(v, count + 1);
        end
    end

end

--拷贝自cocos2d extern.lua文件中
function Clone(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

--拷贝自cocos2d extern.lua文件中，并修改及简化
--全局
function Class(classname, super)
    local cls
    -- inherited from Lua Object
    if super then
        cls = Clone(super)
        cls.super = super
        --修改spuer可以为普通table
        if not cls.Ctor then
            cls.Ctor = function() end
        end
    else
        cls = {Ctor = function() end}
    end

    cls.__cname = classname
    cls.__ctype = 2 -- lua
    cls.__index = cls

    function cls.New(...)
        local instance = setmetatable({}, cls)
        instance.class = cls
        instance:Ctor(...)
        return instance
    end
    function cls.Create(...)
        return cls.New(...)
    end
    return cls
end

Parent = Class("Parent", Object);
function Parent:Ctor(type)
    self.type = type ;
end

Child = Class("Child", Parent);
function Child:Ctor(taskId)
    Parent.Ctor(self, 1)
    self.taskId = taskId
end

local obj = Child.New(1001);
print(obj.type)
TablePrint(obj)
print("-------------------------------")
TablePrint(obj.__index)


----------------------------------------------------------------------
[[  
    1、继承全靠 Parent.Ctor(self, ...)这里会调用 父类 的Ctor函数，而父类中的Ctor
        函数又是 冒号: 写的，所以默认第一个参数是self，其实这个self是传入的类。
        如果写成 
        Parent.Ctor(Child, ...)
        {
            Child.id = 10;
            Child.type = 100;
        }
        可能会更清楚一些，子类借父类的函数初始化了子类的数据，而不是数据只有父类
        一份。
    2、关于 __index ，索引tab.index， 
        如果 tab 中有index，则直接用；
        如果没有，则从它的元表的__index中查找，
        如果还没有，则从它的元表的元表的__index 中查找。

        如果tab本身没有__index, 但进行了 setmetatable(tab, metable),
        此时若metable中有__index, 则tab的 __index 也是metable.__index

        __index 只有通过元表设置，才能获取到值，如果本身直接设置，则只是一个变量。
        例如 
            tab = {}; tab.__index = {a= 1};  tab.a 为nil

            mat = {a = 2}
            setmetatable(tab, mat);          tab.a 为nil

            mat = {a = 2}
            mat.__index = mat;
            setmetatable(tab, mat);          tab.a 为2

]]
