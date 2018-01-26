local f = assert(io.open("test.txt", "rb"))

local data = f:read("*all");
local validchars = "[%w%p%s]";
local pattern = string.rep(validchars, 6) .. "+%z"
for w in string.gmatch(data, pattern) do
    print(w)
end
