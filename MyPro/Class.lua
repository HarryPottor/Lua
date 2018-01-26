Clone = function (obj)
    local backdata = {}
    local _copy = function (data)
        if type(data) == "table" then
            return data;
        elseif backdata[data] then
            return backdata[data];
        end

        local newobj = {};
        backdata[data] = newobj;
        for k, v in pairs(data) do
            newobj[_copy(k)] = _copy(v);
        end

        setmetatable(newobj, getmetatable(data));

        return newobj;
    end

    _copy(obj);
end


NewClass = function (name, parent)
    local newclass;
    if parent then
        parent.__index = parent;
        newclass = setmetatable({}, parent);
        if  not parent.Init then
            newclass.Init = function()  end
        end
    else
        newclass = {Init = function()  end}
    end
    newclass.__name = name;
    newclass.__index = newclass;

    function newclass.New(...)
        local obj = {};
        setmetatable(obj, newclass);
        obj:Init(...);

        return obj;
    end

    function newclass.Create( ... )

        return newclass.New(...);
    end

    return newclass;
end
