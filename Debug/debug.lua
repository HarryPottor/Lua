debug.sethook(print, "l")
function show(info)
    local tab = debug.getinfo(1, "L")
    for k,v in pairs(tab) do
        print(k,v)
    end
    traceback()
end



function traceback()
    for level = 1, math.huge do
        local info = debug.getinfo(level, "SL");
        if not info then break; end
        if info.what == "C" then
            print(level, "C function")
        else
            print(string.format("[%s]:%d", info.short_src, info.linedefined))
        end
    end
end

show()