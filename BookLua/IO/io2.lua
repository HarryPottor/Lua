io.input("input.txt");

strcont = io.read("*all");
strcont = strcont .. "\n";
local tab = {}
string.gsub(strcont, "(.-)\n", function (line)
    if string.len(line) > 0 then
        tab[#tab+1] = line;
    end
end)
for k,v in pairs(tab) do
    print(k,v)
end

--[[

for count = 1, math.huge do
    local line = io.read()
    if line == nil then
        break;
    end
    io.write(string.format("%6d ", count), line, "\n");
end

--]]