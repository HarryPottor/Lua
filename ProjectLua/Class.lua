local function Clone(tab)
    local backtab = {};

    function _copy(data)
        if  type(data) ~= "table" then
            return data;
        elseif backtab[data] then
            return backtab[data];
        end
        local newtab = {};
        backtab[data] = newtab;
        for k, v in pairs(tab) do
            newtab[_copy(k)] = _copy(v);
        end
        setmetatable(newtab, getmetatable(tab));
        return newtab;
    end

    return _copy(tab)
end

function NewClass(classname, parent)
    local class;
    if parent then
        class = Clone(parent);
        class.parent = parent;
        if not class.Init then
            class.Init = function() end;
        end
    else
        class = {Init=function () end}
    end
    class.__index = class;
    class.__name = classname;
    class.__type = 2;

    function class.New(...)
        local obj = {};
        setmetatable(obj, class);
        obj.class = class;
        obj:Init(...);

        return obj;
    end

    function class.Create( ... )
        return class.New(...);
    end

    return class;
end


