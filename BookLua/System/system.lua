start = os.clock();
print(os.time())
Desc = [[
    os.time() 返回的秒数是 格林威治时间 是个时间段。
        格林威治的起点是00:00:00；
        北京的起点是08:00:00
        里约热内卢 起点是 21:00:00
    西三区 1970.1.1.0.0.0 -> 10800秒 
    子午线 1970.1.1.0.0.0 -> 0秒
    所以推出 东边时间 比 西边时间 小

    os.date("mode", time=cur) 返回当前或设置时间的 table或字符串
        "mode" = "*t" 返回 time的table数据
        "mode" = ""   返回 字符串
                %a 星期简写 %A 星期全称
                %b 月份简写 %B 月份全称
                年月日 %Y(%y) %m %d   Y 1989 y 89
                时分秒 %H(%I) %M %S   H 24   I 12
                %w 一个星期中的第几天
                %d 一个月中的第几天
                %j 一年中的第几天
                %p am or pm
                %c 日期和时间 %x 日期 %X 时间
    os.clock() cup 时间
]]
tab = {year=1970, month=1, day=1, hour=8}
print(os.time(tab))

tab = os.date("*t", 3600);
print(string.format("%04d-%02d-%02d %02d:%02d:%02d", tab.year, tab.month, tab.day, tab.hour, tab.min,tab.sec))

print(os.date("%c"))
print(os.date("%x"))
print(os.date("%X"))
print(os.date("%Y-%m-%d %H:%M:%S"))
str = ""
tab = {}
for i=1,100000 do
    --str = str .. "abc"
    tab[#tab + 1] = "abc";
end
str = table.concat(tab)

print("use time :", os.clock() - start)

Desc = [[
    os.exit 终止当前程序执行
    os.getenv 获取一个环境变量的值
    os.execute 运行一条系统命令

]]
os.execute("mkdir " .. "haha")
print(os.setlocale(nil))