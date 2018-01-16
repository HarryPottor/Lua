--[[
1、dofile 其实执行的是 loadfile
    loadfile 加载一个文件，编译代码，并将结果作为一个函数返回。
        遇到错误，只是返回错误值，并不处理.
    可以保存loadfile的结果多次调用，避免多次编译
--]]

func = loadfile("func.lua")
func()
tab = {123,23,34}
showTable(tab)

--[[
2、loadstring 用于加载一个字符串，返回一个函数
    每次loadstring的时候都将编译一遍程序
    loadstring 不涉及词法域，所用的变量都是全局的。
    如果需要对一个表达式求值，需要 之前加上 return
    loadstring 函数返回的 函数是自带变长参数的
--]]
a = 10;
local a = 0;
strfunc = loadstring("a = a+ 1; print(a)");
strfunc2 = function () a= a+1; print(a) end
strfunc();  --全局的a
strfunc2(); --局部的a

-- local l = io.read();
l = 100;

--这时候的 l 就近原则取值
local func = assert(loadstring("local x = ...; return x+" .. l));
print(func(12));

--[[
3、不要认为 loadfile,loadstring 是加载了一个程序块，定义了其中函数
    定义函数 其实 是在运行时的赋值操作,即在运行时才完成。
--]]

--print("input a number")
--n = assert(io.read("*number"), "invalid input");


-- local file, msg;

-- repeat
--     print("enter a file name:");
--     local name = io.read();
--     file, msg = io.open(name, "r");
--     if not file then print(msg) end
-- until file;

--[[
4、使用pcall来调用一些受保护的函数，处理异常
--]]


function foo()
    error({code=121})
end


local status, err = pcall(foo)
if  status then

    print "OK";
else
    print ("Error", err.code);
end

print(debug.traceback())


--[[
5、xpcall(runFunc, errFunc) 用errFunc函数来处理发生报错时处理函数
    调用pcall返回其错误时，销毁了调用栈的部分内容（从pcall到错误发生点的这部分调用）
    用xpcall会在栈展开前调用错误处理函数，在这个函数中可以用debug库来获取错误的
    额外信息。 debug.debug, debug.traceback;

--]]
function runfunc()
    error("run error", 2);
end

status, err = pcall(runfunc)
print(err)

function errorfunc()
    print(debug.traceback())
end


xpcall(runfunc, errorfunc)
