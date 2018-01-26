info= [[
.(点): 与任何字符配对
%a: 与任何字母配对
%c: 与任何控制符配对(例如\n)
%d: 与任何数字配对
%l: 与任何小写字母配对
%p: 与任何标点(punctuation)配对
%s: 与空白字符配对
%u: 与任何大写字母配对
%w: 与任何字母/数字配对
%x: 与任何十六进制数配对
%z: 与任何代表0的字符配对
%x(此处x是非字母非数字字符): 与字符x配对. 主要用来处理表达式中有功能的字符(^$()%.[]*+-?)的配对问题, 例如%%与%配对
[数个字符类]: 与任何[]中包含的字符类配对. 例如[%w_]与任何字母/数字, 或下划线符号(_)配对
[^数个字符类]: 与任何不包含在[]中的字符类配对. 例如[^%s]与任何非空白字符配对
]]


local function name2node(graph, name)
    if  not graph[name] then
        graph[name] = {name = name, adj = {}};
    end
    return graph[name];
end

function readgraph()
    local graph = {};
    for line in io.lines() do
        local namefrom, nameto = string.match(line, "(%S+)%s+(%S+)");
        local fromnode = name2node(graph, namefrom);
        local tonode = name2node(graph, nameto);
        fromnode.adj[tonode] = true;
    end

    return graph;
end

--深度优先算法的 路径查找
function findpath(curr, to, path, visited)
    path = path or {};
    visited = visited or {};

    if visited[curr] then
        return nil;
    end

    visited[curr] = true;
    path[#path + 1] = curr;

    if curr == to then
        return path;
    end

    for node in pairs(curr.adj) do
        local p = findpath(node, to, path, visited);
        if p then
            return p;
        end
    end
    path[#path] = nil;
end

function printpath(path)
    for i,v in ipairs(path) do
        print(i,v.name)
    end
end


g = readgraph();
a = name2node(g, "a");
b = name2node(g, "v");
p = findpath(a,b);
if p then
    printpath(p)
end