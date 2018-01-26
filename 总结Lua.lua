1 注释的方式 --[[ ... --]]
    --[===[ ...  --]===]
    字符串的方式  [[ ... ]] 
        [===[ ... ]===]
  解释器程序:
    lua [选项参数] [脚本[参数]]
        -l 用于加载库文件
        -i 运行完其他指令后，进入交互模式
        -e 直接在命令行中输入代码  ex. lua -i -l a -e "x=10"
            ex. 修改提示符: lua -i -e "_PROMPT=' lua> '"
    unix 中 shell直接执行 lua文件，需要在文件开头加上:
        #! /user/bin/lua  即lua存在的路径
    % lua 脚本 a b c
        在全局变量中 arg 为参数tanle，[0] = 脚本名称,[1]=a,...

2 类型与值
    type() 获取类型
    科学计数法: 1.23e-3
    string: 遇到算术操作符，会自动将字符串转为数字，不能转换了味错误
            遇到 .., 会自动将内容转为string .
            #str 获取长度
    table:  tab["name"] 的写法 等同于 tab.name
            tab[10] 不等于 tab["10"] 不等于 tab["+10"] 可用过相等性测试
            #获取数组tab的长度，必须是连续的
            table.maxn(tab) 获取数组tab最大的index

3 表达式
    精确到小数后两位: x - x%0.01
    x = x or v;
    max = (x > y) and x or y;
    优先级: ^
            not # -
            * / %
            + -
            ..
            < > <= >= ~= ==
            and
            or
4 语句
    语句块：do
            ...
            end
5 函数
    多重返回值:如果不是赋值的最后一个值，或者参数列表中不是最后一个,
        或者初始化一个table， 则只有第一个值有用
    a,b,c = foo2(), 10,     => a = foo2第一返回值,b = 10, c=nil
    tab = {foo2(), 10},     => tab[1] = foo2第一返回值, tab[2] = 10
    return 后边带() 的写法， return (foo2()) 不管foo2()返回多少个结果，return
        只返回1个结果，且不是尾调用
    unpack({1,2,3}) 返回数组中的所有元素
    函数中的可变参数 ... ，有个table变量会保存它 arg，或者直接写成{...}
    select('#', ...)    获取...的长度, 包括nil; arg.n 也是这个值
    select(index, ...)  获取 ... 中从index起始的参数
    ex. ... 是 1,2,3,4  select('#', ...) = 4; select(2, ...)=2,3,4
    ex. function foo2( ... )
            print(unpack(arg))
        end
6 深入函数
    closure 闭合函数  引用的外部变量 叫 非局部的变量。
        函数可以看成closure，不包含外部变量的closure
        创建的closure会 再创建一份 非局部变量。
    非全局的函数
        local g = function ( ... )
            -- body
        end

        local function f( ... )                 local f;
                                       =>       f = function (...)
        end                                     end
        因此使用递归的时候，f的方式正确，g的方式因为g尚未初始化完成不行。
    尾调用

7 迭代器与泛型for
    closure 的迭代器， 需要closure本身，和创造closure的factory.
    可以使用factory作为 in 后边的数据:
        for value in factory() do
            ...
        end
    迭代器:
        for var1,..., varn in <explist> do <block> end
        等同于:
        do
            local _f, _s, _var = <explist>
            while true do
                local var1, ..., varn = _f(_s, _var)
                //!!!注意这里：_f 函数返回的第一个值是下次_f的第二个参数!!!
                _var = var1;
                if _var == nil then
                    break;
                end

                <block>
            end
        end

8 编译
    loadfile() 编译代码，返回可执行函数
    dofile() 编译执行代码

    loadstring() 开销较大, 不涉及词法域，

    assert(loadfile())
    assert(loadstring())

    pcall(func, args) 返回是否成功和func的返回值
    error("info", level)
    print(debug.traceback())

9 协同程序
    co = coroutine.create(func); 创建
    coroutine.status(co); 打印状态
    coroutine.resume(co);  启动或再次启动 
    coroutine.yield(args); 挂起

    注意参数和返回值得传递。把 resume 和 yield 的执行与返回值看成两个过程.
    res1 = resume(arg1)  s1 = s2
    res2 = yield(arg2)   s3 = s4
    执行s2时, 如果协同程序不是yield挂起的，则arg1则作为程序的参数；
              如果是yield挂起的，则arg1 则为 res2,  即：s2转为s3状态
              如果程序结束了，则返回程序的返回值
    执行s4时，调用resume的地方将返回 arg2， 即 s4->s1

11 数据结构
        table.concat( tablename, ", ", start_index, end_index )
13 元表
    table 和 userdata 可以有各自独立的元表
    getmetatable(t)
    setmetatable(t, m)
    __add   __sub   __mul   __div   __unm   __mod   __pow   __concat
    __eq    __lt    __le     
    __tostring      __metatable     
    __index __newindex

14 环境
    rawset(_G, name, value);
    rawget(_G, name)

    debug.getinfo(2, "S").what 返回调用者是普通函数还是主程序块

    设置函数自己的环境
    setfenv(1, {});
    setfenv(1, {g= _G});
    setfenv(1, {__index= _G});

15 模块与包
    require 函数
    function require(name)
        if not package.loaded[name] then
            local loader = findloader(name);
            if loader == nil then
                error(....)
            end
            [[这里现在package.loaded 表中 设置为 true]]
            package.loaded[name] = true;
            [[  加载文件内容，如果有返回值则，package.loaded 中的值就是返回值
                否则是 true]]
            local res = loader(name);
            if res ~= nil then
                package.loaded[name] = res;
            end
        end
        return package.loaded[name];
    end
    [[加载过的模块不会重新加载，除非设置 loaded[name] = nil]]
    加载的路径:
    print(package.path)
    print(package.cpath)
        C 模块 用 package.loadlib

    require 模块之后，一是返回了一个table，二是在全局中设置了一个全局变量

    编写一个模块
        local modname = ...; //这是require函数传入的
        local M = {};   //模块表
        _G[modname] = M;    //这样在全局中就有该模块了
        package.loaded[modname] = M;//这样就不用写返回值
        setfenv(1, M); //设置环境，里面的函数就不用再加前缀了；
        [[若要引用外部的 模块，在 setfenv之前 导入]]

    使用 module 函数
        module(..., package.seeall)

16 面向对象
    function Account:new(obj)
        obj = obj or {};
        setmetatable(obj, self);
        self.__index = self;
        return obj
    end

    SubAccount = Account:new();//SubAccount 是 Account 的对象,同时它有生成对象的能力，因为他有继承来的 new 函数.
    SubSubAccount = SubAccount:new();// SubAccount 的子类

    多重继承:
        生成 类:
            function CreateClass(...)
                local c = {}
                local parents = {...};
                setmetatable(c, {__index=function(t, key)
                        return search(k, parents);
                    end})
                c.__index = c;
                function c:new(obj)
                    obj = obj or {};
                    setmetatable(obj, c);
                    return obj;
                end

                return c;
            end

18 数学库
19 table库
    table.insert(tab, index, info)
    table.insert(tab, info)
    table.remove(tab, index)
    table.sort(tab, sortfunc);
    table.concat( tablename, ", ", start_index, end_index )
20 字符串库
    string.lower(str)
    string.upper(str)
    string.sub(str, i, j)
    string.char(97, 98)
    string.byte("abc", 1,2)
    string.format(fmt, ...)

    find, match, gsub, gmatch 都是基于模式
    string.find(str, "aaa")  返回起点index和终点index
    string.match(str, "%d+%d+%d") 返回子串
    string.gsub(str, "%w+", "info"|function|table, counts) 返回替换后的串和替换的个数
    string.gmatch(str, "%w+") 遍历str，返回匹配到的串

    %a, c, d, l , s, p, u, w, x, z
    大写表示取反
    %b() 匹配组合
    ()捕获可用%0,%1 表示捕获到的东西
    . 一个字符
    + 1 or more
    - 0 or more 最少匹配
    * 0 or more 最多匹配
    ? 0 or 1
    [] 字符集
    [^]取反的字符集
    ^ 开头
    $ 结尾

21 IO库
    io.input(filename) io.output(filename)
    io.write(str1, str2)
    io.read("*all"|"*line"|"*number"|<number>)
    io.open(filename, "mode")
22 系统库
    os.rename(oldname, newname);
    os.time()
    os.date("*t"|"%Y%m%d - %H%M%S")
    os.clock()

    os.exit()
    os.getenv(str)
    os.execute("mkdir " .. dirname)