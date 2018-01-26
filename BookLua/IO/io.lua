Desc = [[
    io.input(filename);
    io.output(filename);
    io.write(arg1, arg2, ...)
    io.read()  //参数: "*all" "*line" "*number" "<num>" 读取不超过num个字符的字符串
    io.read(0) 是否文件读取完了，没完 返回空串，完了 nil


    读取只能一遍

    tmpfile 返回一个临时文件的句柄，程序结束时自动删除
    flush 将缓冲数据写入文件
    file:seek(whence, offset)
                set     相对于文件起始的偏移
                cur     当前位置
                end     结尾
    file:seek() 返回当前位置
    file:seek("set") 当前位置 重置为 文件起始，返回0
    file:seek("end") 当前位置 重置为 文件末尾，返回文件大小

]]


io.input("input.txt");

cont = {}
for line in io.lines() do
    local pos = io.input():seek("end");
        print(pos)
    cont[#cont + 1] = {}
    for value in string.gmatch(line, "%d+") do

        table.insert(cont[#cont], tonumber(value));
        table.sort(cont[#cont]);
    end
end


io.output("output.txt");
for k, v in pairs(cont) do
    if type(v) == "table"  then
        if #v > 0 then
            io.write(table.concat(v, ","),"\n");
        end
    else
        io.write(tostring(v) , "\n");
    end
end

