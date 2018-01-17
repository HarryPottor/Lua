Desc = [[
    全局变量中不能有nil，为了让它存在nil的变量。
    创建一个新表，用于保存声明的变量。调用元方法时，检测该表中是否有该变量。
    也就是说，检测是否存在的表和实际的_G 的表是两张不同的表。

    现在这个版本：
        允许在主程序中创建全局变量，全局变量可以是nil；
        不允许使用全局变量中未声明过的变量。
]]

local declaredNames = {};

setmetatable(_G, {
    __newindex = function (t, n, v)
        if not declaredNames[n] then
            local w = debug.getinfo(2, "S").what;
            if  w ~= "main" and w ~= "C" then
                error("attempt to write to undeclared variable" .. n, 2);
            end
            declaredNames[n] = true;
        end
        rawset(t, n, v);
    end,
    __index = function (_, n)
        if not declaredNames[n] then
            error("attempt to read undeclared variable" .. n, 2)
        else
            return nil;
        end
    end

    })

x = nil;
print(x)
print(y)