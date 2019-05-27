function TableLength(T)
	if not T then
		return 0;
	end

	local count = 0
	if type(T) == "table" then
		for _ in pairs(T) do count = count+1 end
	end
	return count
end


local tb = {}
for	i = 1, 1000000 do
	tb[i] = i;
end




local num
now = os.clock()


for	i = 1, 100 do
	num = #tb
end

print("num = " .. tostring(num))
print(os.clock()-now)
print("------------------------------------")

local num1
local now = os.clock()

for	i = 1, 100 do
	num1 = TableLength(tb)
end

print("num1 = " .. tostring(num1))
print(os.clock()-now)

print("------------------------------------")


-- #调用 比 遍历快了几千倍