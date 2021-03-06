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

HyperLinkContext = Class("HyperLinkContext", Object);
function HyperLinkContext:Ctor(type)
    self.type = type ;
end

HyperLinkContextTask = Class("HyperLinkContextTask", HyperLinkContext);
function HyperLinkContextTask:Ctor(taskId)
	HyperLinkContext.Ctor(self, 1)
    self.taskId = taskId
end

local obj = HyperLinkContextTask.New(1001);
print(obj.type)
TablePrint(obj)
print("-------------------------------")
TablePrint(obj.__index)



