Desc = [[
    require "模块名"; 
        该调用会返回一个由模块函数组成的table(前提是如果有返回值的话)
        并且定义一个包含该table的全局变量.
]]
require "tool"
Tool.showTable({abc=12, bd=23})

for k, v in pairs(_G) do
    if  k == "Tool" or k == "Func" then
        print(k, v)
    end
end

Desc = [[
    去掉加载的数据，可以重新加载，
    如果不去掉，再次加载会直接返回上次的值。
]]
package.loaded["tool"] = nil;


Desc = [[
    require 的搜索路径: package.path package.cpath
    LUA_PATH;LUA_CPATH   --在系统的环境变量里面
    ?;?.lua;c:\windows\?;/usr/local/lua/?/?.lua;
    用模块名字 替换 ?
    每一项都是一个文件。
    C:\Program Files (x86)\Lua\5.1\lua\?.lua;
    C:\Program Files (x86)\Lua\5.1\lua\?\init.lua;
    C:\Program Files (x86)\Lua\5.1\?.lua;
    C:\Program Files (x86)\Lua\5.1\?\init.lua;
    C:\Program Files (x86)\Lua\5.1\lua\?.luac

    LUA_PATH 中的 ;; 会翻译为默认路径。
]]

print(package.path)
LUA_PATH = "D:\?.lua;;"
print(package.cpath)

Desc = [[
    如果require的文件有重名的:lua的文件直接改；
    c的lib库文件改名为 a_b; 这样requie认为它的open函数为luaopen_b，
        而不是luaopen_a_b

]]