function declare(name, initval)
    rawset(_G, name, initval or false);
end

setmetatable(_G, {
    __newindex = function (t, n, v)
        local w = debug.getinfo(2, "S").what;
        print(w, n, v)
        if  w ~= "main" and w ~= "C" then
            error("attempt to write to undeclared variable" .. n, 2);
        else
            rawset(t, n, v);
        end
    end,
    __index = function (_, n)
        error("attempt to read undeclared variable" .. n, 2)
    end

    })

-- a = 12;
-- print(a);

-- 如何设置全局变量 
-- 方法1：
declare("a", "abv");
print(a)

-- 方法2：只允许在主程序中对全局变量赋值
-- 获取 是主程序还是普通函数  debug.getinfo(2, "S").what    (main,C, Lua)

name = "lucy";
print(name)

function test()
    --age = 12;
end

test()

Desc = [[
    如果直接调用-G["grade"]则会调用到元方法__index,则会报错，
        如果不想报错，则使用rawget(_G, "grade") 跳过元方法
]]
if rawget(_G, "grade")  == nil then
    print("grade is nil");

else
    print("grade is not nil");
end