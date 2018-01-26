Desc1 = [[
    用于获取 类似"a.b.c.d" 这类的值
]]
function getfield(f)
    local v = _G;
    for w in string.gmatch(f, "[%w_]+") do
        v = v[w];
    end
    return v;
end

-- num = getfield("io.read")()
-- print(num)

Desc2 = [[
    用于设置 类似"a.b.c.d" 这类的值
]]

function setfield(f,v)
    local t = _G;
    for w, d in string.gmatch(f, "([%w_]+)(%.?)") do
        if  d == "." then
            t[w] = t[w] or {};
            t = t[w];
        else
            t[w] = v;
        end
    end
end

strname ="data.student.name"
setfield(strname, "lucy");
print(getfield(strname))
print(data.student.name)

strname="name"
_G[strname] = "Lily"
print(name)
