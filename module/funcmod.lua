Desc = [[
    module 做了以下事情 ：
        local modname = ...;
        local M = {}
        _G[modname] = M;
        package.loaded[modname] = M;

        setfenv(1, M)
    添加额外的模块，用第二个参数 package.seeall 
        该方法与继承相似(__index = _G)

    对于新创建的 module，会自动添加 _M 模块自身；_NAME 模块名称; _PACKAGE 包的名称 (aa.bb; -> aa) 

]]

local Tool = require "tool"

module(..., package.seeall)
function showinfo(str)
    print(str);
end

function showtable(tab)
    Tool.showTable(tab);
end
