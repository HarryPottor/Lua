__define = {__list = {}}

local function newmsg(o,k,v)
    if  __define.__list[k] ~= nil then
        print("message repeart .... ");
        return; 
    end

    __define.__list[k] = v;

end

setmetatable(__define, {__newindex = newmsg})

function __define.receive_init_data(level, msg)
    print(level, msg);
end

for k,v in pairs(__define) do
    for k1, v1 in pairs(v) do
        print(k1, v1);
    end
end

