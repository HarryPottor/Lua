--[[
co = coroutine.create(function (a,b,c)
    print("co", a, b, c)
end)
--第一次调用，没有yield等待的时候，resume传入的参数就是 主程序的参数
coroutine.resume(co,1,2,3)
--]]


--[[
co = coroutine.create(function (a,b)
    coroutine.yield(a+b, a-b);
end)
-- 进入yidld的时候，resume的返回值就是yield的参数
print(coroutine.resume(co, 30, 10))
--]]

--[[
co = coroutine.create(function ()
    print("co", coroutine.yield()) 
end)

--第一次执行，执行到yield的时候跳出
coroutine.resume(co)
--再次执行，执行到yield的时候存入参数就是yield的返回值
coroutine.resume(co, 4,5)

--]]

co = coroutine.create(function ( ... )
    return 6,7;
end)
--协同程序 结束时的返回值就是resume的返回值
print(coroutine.resume(co))