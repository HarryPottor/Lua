function __getLastModName(name)
    for value in string.gmatch(name, "%w+") do
        name = value
    end
    return name
end

function __getModule(name)
    local M = _G;
    for value in string.gmatch(name, "%w+") do
        M = M[value]
        if  M == nil then
            return nil;
        end
    end
    if  M == _G then
        return nil;
    else
        return M;
    end
end

function __createModule(modname, parent)
    local M = __getModule(modname);
    -- 如果模块 已经在_G 中，说明被加载了，直接返回
    if  M ~= nil then
        return M; 
    end
    -- 创建模块
    module(modname, package.seeall)
    M = __getModule(modname);
    M.__index = M
    if parent ~= nil and type(parent) =="table" then
        setmetatable(M, parent);
        M.__metatable = tostring(parent);
    end

    return M;
end

function __showTable(data, count, loop)
    if loop ~= nil and loop ==0 then
        return ;
    end
    count = count or 0;
    if  type(data) == "table" then
        for k, v in pairs(data) do
            print(string.rep('\t', count), k,v)
            if type(v) == "table" and string.find(k, "_") == nil then
                __showTable(v, count+1, loop - 1);
            end
        end

    else
        print(string.rep('\t', count) .. data);
    end
end

