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

--�������ٶ�����,�����ǻ����� ģ��,��Ʒ��

