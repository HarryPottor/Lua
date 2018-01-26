require "mydll"

local str = "he,hello, hi"
local tab = mydll.mysplit(str, ",")

for k,v in pairs(tab) do
    print(k,v)
end

local str, len = mydll.mystrconnect(#tab, unpack(tab));
print(str, len)

local str = mydll.mypushfstring("<%s : %s %s  %s>", 4, "hello Lua","tianna", "2", 234);
print(str)

local str = "ancdde"
print(mydll.mystrupper(str))

local tab = {"abc", "ghi", "eft", "haha"}
for i =1, #tab do
    print(mydll.mygettable(tab, i))
end

mydll.mysettable(tab, 5, "ppp");
for k,v in pairs(tab) do
    print(k,v)
end


a = mydll.mynewarray(1000);
print(a)
print(mydll.mygetarraysize(a))

for i=1, 1000 do
    mydll.mysetarray(a, i, i % 5 == 0);
end

for i=1, 10 do
    print(mydll.mygetarray(a, i));
end