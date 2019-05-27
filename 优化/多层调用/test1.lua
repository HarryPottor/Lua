local tAvatar = {
    nAnimaID = 0,
    tAnimation = {
        nAnimaID = 0,
}
}

local result = ""

local now = os.clock()
print("=================1==================",  now) -- 0.002
for i = 1, 1000000 do
    tAvatar.nAnimaID = 1
end
print("=================2==================", os.clock() - now) -- 0.046

--尽量减少多层调用,尤其是基础类 模型,物品等

