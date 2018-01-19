Desc = [[
 lua_push nil(L)
 lua_push boolean(L, value);
 lua_push number(L, value)

 lua_is **(L, index)

 lua_to boolean(L, index)
 lua_to integer(L, num);
 
 lua_type(L, index)
 lua_pushvalue(L, index) 将index位置的数据 压入站
 lua_replace(L, index) 将栈顶元素放入 index 位置中，栈顶出栈
 lua_settop(L, index) 如果index 多余 总数量，用nil填充；如果小于，删掉多余的
 lua_pop(L, n) 将前n项弹出
 lua_gettop(L) 返回栈里面的数量
 lua_remove(L, index) 删掉当前的，index上边的下移。
 lua_getglobal(L, name)

 //加载文件 失败返回真；
 (luaL_loadfile) (lua_State *L, const char *filename);
 (luaL_loadbuffer) (lua_State *L, const char *buff, size_t sz, const char *name);
 (luaL_loadstring) (lua_State *L, const char *s);
 //加载 +  执行
 luaL_dofile(lua_State *L, const char *filename)
 luaL_dostring(L, s)


 //获取table 
1 获取全局的table
    lua_getglobal(L, "tablename");
2 将key入栈， 查找key，并放入-1
    lua_pushstring(L, "key")
    lua_gettable(L, -2)
    如果用 lua_getfield(L, -1, key)；
        这一步直接将value放入了 -1；
3 保存value，并清理-1
    int num = lua_tonumber(L, -1);
    lua_pop(L, 1);

//在L中设置table
1 在L中新建table
    lua_newtable(L);
2 把key，value 压入站
    lua_pushstring(L, index);
    lua_pushnumber(L, number);

    如果使用 lua_setfield():
        lua_pushnumber(L, number);
        lua_setfield(L, -2, index);
3 保存kv到table
    lua_settable(L, -3);
4 设置table的名字，出栈
    lua_setglobal(L, name)

//获取lua中的函数
1 获取全局的值
    lua_getglobal(L, "func")
2 设置参数
    lua_pushnumber(L, x);
    lua_pushnumber(L, y);
3 进行调用
    lua_pcall(L, 2, 1, 0); 参数个数，返回值个数
4 获取结果 从栈顶
    z = lua_tonumber(L, -1);
    如果返回三个值: 第一个在-3，第二个在-2，第三个在-1
]]