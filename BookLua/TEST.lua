num = 1.2345
print (num - num%0.001)
print (string.format("%.3f", num))
num = math.floor(num*1000);
print(num/1000)

print(-180 % 360)
a = -100;
b = 300;
print(a%b)


print("-----------------------------")
--[[
list = nil;
for line in io.lines() do
	if line == "Q" then
		break;
	end
    list = {next = list, value = line};
end

temp = list;
while temp do
    print(temp.value)
    temp = temp.next;
end
--]]
print("-----------------------------")
str = "abc,denf,hello,world"
for v in string.gmatch(str,"%a+") do
    print(v)
end
str = "vv,a345e,555d,89"
for v in string.gmatch(str,"%w+") do
    print(v)
end
print("-----------------------------")

local foo2 = function ()
    return "a", "b"
end

local func = function()
    return foo2(),"c"
end

print(func())

print("-----------------------------")
print(unpack({"acx",a = "12", num="vvv", nm=12, "ddd"}))

print("-----------------------------")

func = function ( ... )
    for i=1, select('#', ...) do
            local arg = select(i, ...)
            print(arg)
        end    
end
func("acb", "eee")
print("-----------------------------")

tab = {
    {a="vzx",b="exv",value="123"};
    {a="eed",b="exv",value="123"};
    {a="vvx",b="exv",value="123"};
    {a="rrr",b="exv",value="123"};
    {a="rrr",b="exe",value="123"};
}

local sortfunc = function (item1, item2)
    if  item1.a < item2.a then
        return true;
    elseif item1.a == item2.a and item1.b < item2.b then
        return true;
    end
end

table.sort(tab, sortfunc);

for i,v in ipairs(tab) do
    for i2,v2 in pairs(v) do
        print(i2,v2)
    end
end