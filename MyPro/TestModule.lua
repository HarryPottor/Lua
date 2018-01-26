local modname = ...
module(modname, package.seeall)
function showinfo(obj, x, y)
    print("test module",x, y)
end