require "Class"

-- 引入全局变量
local print = _G.print
local string = _G.string
local pairs = _G.pairs

-- 创建新的模块
local ClassName = "UIBase";
UIBase = NewClass(ClassName);
_G[ClassName] = UIBase;
package.loaded[ClassName] = UIBase;
setfenv(1, UIBase);

-- 类函数
function Init(obj, x, y)
    for k,v in pairs(obj) do
        print(k,v)
    end
    obj.PosX = x;
    obj.PosY = y;
end

function showName(obj)
    print(__name);
end

function showPos(obj)
    print(obj.PosX, obj.PosY); 
end
