DESC= [[
    如果使用 tab.func func中若想使用tab中的变量，则必须使用tab.前缀。
    因为tab名可能会变为tab2，但func 中的函数中的名称还是tab.前缀，所以会错。
    解决方法:在func中将table传入，tab.func(obj, ...);
             或者 使用tab:func() 使用冒号，函数体内 用self, 其实是已经传了
        也就是说 如果函数定义为: 
            function tab:init(num, str)
                print("init : ", num, str)
            end
            调用的方式 tab:init(num, str) | tab.init(tab, num, str) | 
                tab.init(tab, ...)
            function tab.init(num, str)
                print("init : ", num, str)
            end
            调用方式 tab.init(num, str) 
                    如果这样调用:tab:init(num, str)  则传给的第一个形参为table

            ===>>>tab:init(...) == tab.init(tab, ...)
            所以定义函数 最好定义成 tab:init() | tab.init(tab)
                这样两种方法都能用
]]

tab = {
    

}

function tab:init(num, str)
    print("init : ", num, str)
end

function tab.create(tab, num, str)
    print("create : ", num, str)
end

function tab.new(num, str)
    print("new : ", num, str)
end

tab:init(12, "123")
tab.init(tab, 12, "123")

tab.create(tab, 23, "344");
tab:create(23, "344");

--new函数不能用冒号调用，因为它不接受第一个默认参数
function test( ... )
    tab.init(tab, ...)
    tab.create(tab, ...);
    tab.new(...)
end

test(12, "2323")

DESC2= [[
    模块中的函数都是.出来的，

    local modname = ...
    module(modname, package.seeall)
    function showinfo(obj, x, y)
        print("test module",x, y)
    end

    调用的时候:
    require "TestModule"
    TestModule:showinfo(10, 12)
    TestModule.showinfo(TestModule, 10, 12)
]]