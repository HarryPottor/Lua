ArrayDesc = [[
    1、矩阵可以有两种表示方法:
        每一行创建一个table；
        mt = {} -- create the matrix
        for i=1,N do
            mt[i] = {} -- create a new row
            for j=1,M do
                mt[i][j] = 0
            end
        end

        放在一行上:
        mt = {} -- create the matrix
        for i=1,N do
            for j=1,M do
                mt[i*M + j] = 0
            end
        end
    2、无论哪种方法，对于稀疏矩阵，只保存非nil的值。
    3、遍历的时候只能用 pairs，不能保证顺序，如果要顺序用 链表
]]

ListDesc = [[
    list = nil;
    function insert(data)
        list = {next = list, value = data};
    end

    for i=1,10 do
        insert(i);
    end

    while list do
        print(list.value);
        list = list.next;
    end
]]

QueueDesc = [[

]]

List = {}
function List.new()
    return {first = 0, last = -1};
end

function List.pushfirst(list, value)
    local first = list.first-1;
    list.first = first;
    list[first] = value;
end

function List.pushback(list, value )
    local last = list.last + 1;
    list.last = last;
    list[last] = value;
end

function List.popfirst(list)
    local first = list.first;
    if first > list.last then
        error("list is empty")
    end
    local value = list[first];
    list[first] = nil;
    list.first = list.first+1;
    return value;
end

function List.poplast(list)
    local last = list.last;
    if first > list.last then
        error("list is empty")
    end
    local value = list[last];
    list[last] = nil;
    list.last = last - 1;
    return value;
end

SetDesc = [[
    普通集合：同样的字段只能留一份；
    多重集合：同样的字段能留多份。
]]

function Set(list)
    local set = {};
    for i,v in ipairs(list) do
        set[v] = true;
    end

    return set;
end

MulSet = {};
MulSet.Data = {};
function MulSet.insert(elem)
    MulSet.Data[elem] = (MulSet.Data[elem] or 0) + 1;
end

function MulSet.remove(elem)
    local count = MulSet.Data[elem];
    MulSet.Data[elem] = (count and count > 1) and count-1 or nil;
end

StringDesc=[[
    读取一个大文件：
    方法一：
        local buff = ""
        for line in io.lines() do
            buff = buff .. line .. "\n"
        end
        该方法每读一行，则把前边的数据复制一遍到新的，占用了大量时间
    方法二：
        local t = {};
        for line in io.lines() do
            t[#t + 1] = line;
        end
        t[#t + 1] = "" -- 为了在最后添加 "\n"
        s = table.concat( t, "\n");

    方法三：
        io.read("*all")
    方法四:
        汉诺塔存放字符串：
            第一次将字符串放入栈；
            第二次，从栈顶开始循环遍历到栈底，如果i+1的长度 大于 i的长度，
                则连接 i和i+1字符串，存入i, i+1 位置置为nil；
                因为是循环，下次检测 i和 i-1 的字符串。层层向下知道下层大于本层；
            最后一步，table.concat(stack)
]]


function addString(stack, s)
    stack[#stack + 1] = s;
    for i = #stack -1, 1, -1 do
        if  #stack[i] > #stack[i+1] then
            break;
        end
        stack[i] = stack[i] .. stack[i+1];
        stack[i+1] = nil;
    end
end

list = {}
while true do
    local str = io.read();
    if str == "BYE" then
        break;
    end

    addString(list, str);
end

for i, v in ipairs(list) do
    print(i,v);
end

print(table.concat(list));