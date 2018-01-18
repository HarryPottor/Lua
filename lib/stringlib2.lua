Desc = [[
    string.gsub(str, "pattern", x, count);
    x 可以是 字符串，用于替换 查找到的内容；
             table，将查找到的内容作为key，在table中找，如果找到了用value替换；否则不替换
             function ，将找到的内容作为参数传入，用 返回值 替换 
    !!不是找到的内容，是捕获的内容
]]


function expand(str)
    return string.gsub(str, "%$(%w+)", _G);
end

name = "Lucy";
age = 12;

str = "name = $name; age = $age; school= $school";
print(expand(str))


function expand2(str)
    return string.gsub(str, "%$(%w+)", function (con)
        return tostring(_G[con]);
    end);
end

name = "Lucy";
age = 12;

str = "name = $name; age = $age; school= $school";
print(expand2(str))

-- 嵌套风格的 转换
str = [[ \\title{The \\bold{big} example} ]];

function toxml(str)
    return string.gsub(str, "\\\\(%a+)(%b{})", function (name, cont)
        cont = string.sub(cont, 2, -2);
        cont = toxml(cont)
        return string.format("<%s>%s</%s>", name, cont, name)
    end)
end

temp =toxml(str); 
print(temp)
print(toxml(temp))

print("-------------------------------------")

INFO = [[
    URL 编码:   特殊字符 转为 %xx 十六进制
                key 与 value 转为 key=value
                kv 与 kv2 转为 kv&kv2
]]

function unescape(str)
    str = string.gsub(str, "+", " ");
    str = string.gsub(str, "%%(%x%x)", function (h)
        return string.char(tonumber(h, 16));
    end)
    return str;
end

print(unescape("a%2Bb+%3D+c"))

cgi = {}
function decode(s)
    for name, value in string.gmatch(s, "([^=&]+)=([^=&]+)") do
        name = unescape(name);
        value = unescape(value);
        cgi[name]=value;
    end
end

decode("name=a1&query=a%2Bb+%3D+c&q=yes+or+no");
for k,v in pairs(cgi) do
    print(k,v)
end

print("--------------tab-----------------------")
Info = [[
    格式化字符串，遇到 \t 将字符串对齐8位 例如 ab\tc\t =>  abxxxxxx cxxxxxxx
    !!cor 是个增量，每次补充完后，总共的添加的数量；
        cor + index  -1 是补全字符串中总共的字节数num; num%8=x最后的8位占了x位
        8 - x = 需要补全的空白数
]]
function tab2space(str, num)
    count = num or 8;
    cor = 0;
    str = string.gsub(str, "()\t", function (index)

        sp = count - (index-1 + cor)%count
        cor = cor+ sp - 1;
        return string.rep(" ", sp)
    end)
    return str;
end

function tab2space2(str, num)
    count = num or 8;
    lastindex = 0;
    str =  string.gsub(str, "()\t", function (index)
        sp = count - (index-1 - lastindex)%count
        lastindex = index;

        return string.rep(" ", sp)
    end)
    return str;
end
str = "aa\tbbb\tcccc";
print(str)
res = tab2space2(str);
print(res);

info =[[
    pat 是获取8个字符，
    %0\1  在8个字符后添加\1
    替换" \1" 为\t
    去掉8位中没有空格的\1
]]
function space2tab(s, tab)
    tab = tab or 8;
    local pat = string.rep(".", tab);
    s = string.gsub(s, pat, "%0\1");
    s = string.gsub(s, " +\1", "\t");
    s = string.gsub(s, "\1", "")
    return s;
end

print(space2tab(res))


