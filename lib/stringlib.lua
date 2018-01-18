str = "abc";
print (str:upper())
print (str:rep(3))


Desc = [[
    不区分大小写的比较
]]
tab = {"abv", "Avc","Aae"}
table.sort(tab, function (a, b)
    return a:upper() < b:upper();
end)

for k,v in pairs(tab) do
    print(k,v)
end

Desc = [[
    str:sub(1, j); 获取str的前j个前缀
    str:sub(j); 获取从j开始的后缀
]]
str = "1234567890"
print(str:sub(2, -2))


Desc = [[
    string.char 数字转为字符
    string.byte 字符转为数字
]]

print(string.char(97))
print(string.char(97, 98, 99))
print(string.byte("abc"))
print(string.byte("abc", 2))
print(string.byte("abc", 1, -1))

print(string.format( "%02d/%02d/%04d", 2, 18, 2019));

Desc = [[模式
    string.find(str, des, startindex) 返回起始坐标和终止坐标
    string.match(str, "pattern")  返回字符串
    string.gsub(str, "pattern", "str", limit_count) 替换完成后的字符串,替换的次数



    [] 一个 字符集,仅仅代表一个字符  例如变量名字的模式 "[_%a][%w_]*"
    []+ 一个或多个这个模块
    [^;]+ 一个或多个 非; 的模块 

    %a 字母 c 控制字符 d数字 l小写 u大写 p标点 s空白 w字母数字 x十六进制 z内部为0的字符
    "%b<a><b>" 用于匹配成对的 "%b()" 匹配括号
    大写表示补集
    魔法字符:  ()  . % +-*? [] ^ $
    () 进行捕获, 用 string.match() 返回所有的值
    ^不在字符集 表示匹配开头
    $ 表示匹配结尾
    例如 "~[+-]?%d+$"匹配一个整数
    %用来转义
    + >= 1
    - >= 0      尽可能少的匹配 例如str = "/* */  /* */" ("/%*.-%*/")匹配/* 和最近的 */
    * >= 0      尽可能多的匹配                 ("/%*.*%*/")*只能匹配第一个 /* 和最后一个 */ 相结合
    ? 0/1       可选 [+-]? 可选的正负号

]]

str = "abcdefadefkadfencdeflaiefdale alsfsdfaedaed";
local s, e = string.find(str, "fa", 1);
while s ~= nil do
    print(s)
    s, e = string.find(str, "fa", e+1);
end

date = "today is 2018.1.18";
print(string.match(date, "%d+.%d+.%d+"))
temp = string.gsub(date, "today", "tomorrow");
print(temp)
print (string.gsub(temp, "%d+.%d+.%d+", "2018.1.19"))

print("----------------------------------------------")

function search(modname, path)
    modname = string.gsub(modname, "%.", "/");
    for c in string.gmatch(path, "[^;]+") do
        local fname = string.gsub(c, "?", modname);
        print(fname);
        local f = io.open(fname);
        if f then
            f:close();
            return fname;
        end
    end
    return nil;
end

search("abc.ac.fg", package.path)

print("----------------------------------------------")


str = "_abc, def, b_v, 12_"
print("-------------------------  [%w_]+" )

for v in string.gmatch(str, "[%w_]+") do
    print (v)
end

print("-------------------------  [_%a][_%w]-" )
for v in string.gmatch(str, "[_%a][_%w]-") do
    print (v)
end

print("-------------------------  [_%a][_%w]*" )
for v in string.gmatch(str, "[_%a][_%w]*") do
    print (v)
end

str = "int a = 10; /*infoa*/; int b=20; /*infob*/"
print("-:",string.gsub(str, "/%*.-%*/", "<COMMENT>"))
print("*:", string.gsub(str, "/%*.*%*/", "<COMMENT>"))

desc=[[
    捕获
]]

str = " abc = lala    ";
local s1, s2 = string.match(str, "(%a+)%s*=%s*(%a+)");
print(s1, string.len(s1),  s2, string.len(s2))

str = [["abdedef" say : "hello"]]

Desc=[[
    1 获取 “” /‘’ 的内容 
    2 如果内容为 He say : "It's right" 其中的一个 ' 则错误匹配；
        可以获取获取第一个引号， 并以此为结束引号
        "([\"\'])(.-)%1"  捕获的第一个引号 在以后可以用%1 来获取。
        例如匹配 [==[...]==]    "%[(=*)%[(.-)%]%1%]"

    string.match 
    string.gsub 都可以用 捕获的值 %0 捕获到的全部
]]
print(string.match(str, "[\"\'].-[\"\']"))
for v in string.gmatch(str, "[\"\'].-[\"\']") do
    print(v)
end

str = [[He say "It ' right " ]]

q, info = string.match(str, "([\"\'])(.-)%1");
print(info)

str = "a = [=[ [[hello world]] ]==] ]=], print(a)";

sq, info = string.match(str, "%[(=*)%[(.-)%]%1%]")
print(info)

str = "abc"
print(string.gsub(str, "(.)(.)", "%2%1"))

str = [[\command{some text}]]
print(string.gsub(str, "\\(%a+){(.-)}", "<%1>%2</%1>"));
str = [[the \quote{task} is to \em{change} that]];
print(string.gsub(str, "\\(%a+){(.-)}", "<%1>%2</%1>"));

Desc=[[
    总结一下：
    string.upper(str)
    string.lower(str)
    string.char(...) 数字转为字符
    string.byte(str, s, e) 字符转为数字

    string.find(str, des, startindex) 返回起始坐标和终止坐标
    string.sub(str, 1, j); 获取str的前j个前缀
    string.sub(str, j); 获取从j开始的后缀

    string.match(str, "pattern")  返回字符串
    string.gmatch(str, "pattern")  返回字符串
    string.gsub(str, "pattern", "str", limit_count) 替换完成后的字符串,替换的次数
]]

