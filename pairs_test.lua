local tab = {"acc", "eed", "ffg", "nvnvn", "adf", ".,b"}

function Noiter(t, index)
	index = index + 2;
	local v = t[index];
	if	v then
		return index, v;
	end
end

function NoState(t)
	local index = 0;
	return Noiter, t, index;
end

for i,v in NoState(tab) do
	print(i,v)
end

print("--------------------------------------------")

function Muliter(state, index)
	index = index + 1;
	local v = state["list"][index];
	if	v then
		if	string.find(v, state.flag) then
			return index, v;
		else
			return Muliter(state, index);
		end
	end
end

function MulState(t)
	local state = {list = t, index = 0, flag="a"}
	return Muliter, state, state.index;
end

for i,v in MulState(tab) do
	print(i,v)
end