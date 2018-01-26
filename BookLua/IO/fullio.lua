Desc = [[
    io.open("filepath", mode)
        mode = "r" "w" "a" "b"(打开二进制文件)
    assert(io.open(), "error info")

    默认的文件 io.stdin, io.stdout, io.stderr

    io.input() 不带参数 返回当前文件句柄；
    io.input(f)   带参数，设置当前的文件句柄
]]

local temp = io.input()
file = assert(io.open("fulloutput.txt", "w"), 
    string.format("cannot open %s !", "fulloutput.txt"));
io.output(file)
io.write("abc", "eft")
file:close();

io.input(temp)

Desc = [[
    遇到读取大文件时，不能一次读完，需要分批次，一次读8k;
    可能会从行中间断开，使用以下函数，lines读取到的数据，rest行剩下的数据
    local lines, rest = f:read(BUFSIZE, "*line");
]]


-- 统计 字符数， 行数， 单词数

local BUFSIZE = 2^13;
local f = io.input("test.txt")
local cc, lc, wc = 0, 0, 0;

while true do
    local lines, rest = f:read(BUFSIZE, "*line");
    if not lines then
        break;
    end
    if rest then
        lines = lines .. rest .. "\n"
    else
        lines = lines .. "\n"
    end

    cc = cc + #lines;

    local _, t = string.gsub(lines, "%S+", "")
    wc = wc + t;

    _,t = string.gsub(lines,"\n", "\n");
    lc = lc + t;

end

print(cc, lc , wc);

