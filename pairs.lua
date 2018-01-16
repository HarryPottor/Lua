--[[
--闭包 迭代器
function allwords()
	local line = io.read();
	local pos = 1;
	return function ()
		while line do
			local s, e = string.find(line, "%w+", pos);
			if	s then
				pos = e +1 ;
				return string.sub(line, s, e);
			else
				line = io.read();
				pos = 1;
			end
		end
		return nil;
	end
end

for word in allwords() do
	print(word)
end

--]]

--[[
--闭包迭代器
function Values(t)
 	local index = 0;
 	return function ()
 		index = index+ 1;
 		return t[index];
 	end
end

local t = {123,321,122,221};
for value in Values(t) do
	print(value)
end
--]]

--[[
--没有状态的 迭代器
function iter(a, i)
	i = i+1;
	local v = a[i];
	if v then
		return i, v;
	end
end

function MyIpairs(a)
	return iter, a, 0;
end

local t = {"avc", "ddd", "rer"};
for i, v in MyIpairs(t) do
	print(i,v)
end

-- 闭包的 迭代器
function CloseIpairs(a)
	local index = 0;
	return function ()
		index = index +1 ;
		local v = a[index];
		if	v then
			return index, v;
		end
	end
end

for i, v in CloseIpairs(t) do
	print(i,v)
end

--]]


-- 多状态的迭代器
function MulIter(state)
	while true do
		state.index = state.index + 1;
		local v = state.list[state.index];
		if	v then
			local s, e = string.find(v, state.char);
			if	s then
				return state.index, v, s;
			end
		else
			return 1;
		end
	end
end


function MulState(tab, ch)
	local state = {list=tab, index = 0, char=ch};
	return MulIter, state;
end

t = {"vv", "ddadd", "raer"};
for i,v,s in MulState(t, "a") do
	print(i,v,s);
end

--[[
一，如果迭代器返回的第一个值不为nil，则for循环会一直调用迭代器函数；
二，包装器(包装迭代器的函数) 
	没有状态时：返回三个值：迭代器，状态常量，控制变量。例如ipairs
		控制变量必须是number类型，这样for函数会记录下来。
	闭包：返回一个闭包函数
	多状态：返回两个参数: 迭代器，参数table。
		第二个参数可以是表，所以可以实现多状态.
--]]