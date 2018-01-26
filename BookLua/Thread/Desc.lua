DescThread = [[
    //新建线程，在L的基础上。L的栈顶为该新线程，L1是空线程
    lua_State * L1 = lua_newthread(L)

    lua_xmove(F,T, n) 从F中弹出n个元素，压入T中

    lua_resume(L, narg) 启动一个协同程序，将调用的函数压入栈中，压入参数，调用时传入参数个数。
        如果运行的函数 交出了控制权，它将返回 LUA_YIELD，并将线程置于可再次被恢复执行状态；
        一般情况，返回0 表示正常结束
]]


print(collectgarbage("count"))