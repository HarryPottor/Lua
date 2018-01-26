Desc = [[
 lua_pushnil(L)
 lua_pushboolean(L, value);
 lua_pushnumber(L, value)

 lua_isnumber(L, index)

 lua_toboolean(L, index)
 lua_tointeger(L, num);
 
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


Lua 调用C函数的方法:
在函数中调用C函数：
lua_State* L = lua_open();
luaL_openlibs(L);
luaL_dofile(L, "Config/config.lua");
lua_register(L, "L_Sin", l_sin); //注册函数，并赋予名字 实际是 lua_pushfunction 和 lua_setglobal 的组合 

*.lua
    function cfunc(num)
        return L_Sin(num);
    end

lua_getglobal(L, "cfunc"); //调用lua的中的函数 cfunc， cfunc函数调用了C函数
lua_pushnumber(L, 1.57);
lua_pcall(L, 1, 1, 0);

double res = lua_tonumber(L, -1);
printf("res = %f\n", res);
lua_pop(L, 1);

在全局中调用C函数：
注册完函数之后，需要将文件重新编译一遍。
lua_register(L, "L_Sin", l_sin);
-- 重新编译 方法一:
luaL_dofile(L, "Config/config.lua");
-- 重新编译 方法二：
    luaL_loadfile(L, "Config/config.lua");
    lua_pcall(L, 0, 0, 0);

lua_checknumber(L, index) 检测参数是否是需要的类型，是则返回，不是则报错


使用C的模块：
----------------------------C文件
#include <stdio.h>
#include <string.h>
#include "lua.hpp"
#include <math.h>

//编写函数 读取参数，结果入栈，返回数量。
extern "C" int l_sin(lua_State* L)
{
    double num = luaL_checknumber(L, 1);
    lua_pushnumber(L, num*2);
    return 1;
}

//创建结构变量 为了注册
static luaL_Reg mylib[] = 
{
    { "mysin", l_sin},
    {NULL, NULL}
};

// 模块的入口函数 luaopen_XXX()
// luaL_register(L, "XXX", mylib);
//其中XXX为库的名字，require的时候需要用到的。 生成的动态文件DLL文件名，也是XXX
//这行声明不能少
extern "C" __declspec(dllexport)
int luaopen_mydll(lua_State * L)
{
    luaL_register(L, "mydll", mylib);
    return 1;
}

----------------------------------Lua文件
require "XXX"
print("res = ", XXX.mysin(1))

]]


Desc = [[
    table数组 的 C操作:
    lua_rawgeti(L, index, key);  将栈中index位置的表数据中的key项 入栈
        相当于:lua_pushnumber(L, key); lua_rawget(L, t)
    lua_rawseti(L, index, key);  设置index位置的表的key项数据
        数据一定是在栈顶，key在数据下边
        相当于:lua_pushnumber(L, key); lua_insert(L, -2);lua_rawset(L, t)

    string 的 C操作:
    lua_pushlstring(L, s+i, j-i+1);     //提取子串区间为[i,j]
    lua_concat(L, n);       // 连接栈顶的n个值
    lua_pushfstring(L, "fmt", ...)

    缓冲机制: 使用缓冲时，缓冲会把中间结果放入，不要假设栈顶还是和使用前一样
    luaL_Buffer b;  创建缓冲
    luaL_buffinit(L, &b);   缓冲初始化
    luaL_addchar(&b, ch);   添加数据到缓冲
    luaL_addlstring(&b, ch);
    luaL_addstring(&b, ch);
    luaL_pushresult(&b);    弹出结果

    void luaL_addvalue(&B)   将栈顶的值加入缓冲


]]


Desc_UserData = [[
    userdata 提供了一块原始的内存区域

    lua_newuserdata 会根据指定的大小分配一块内存, 并将对应的userdata压入站中
        返回内存块的地址
        void * lua_newuserdata(lua_State * L, size_t size);

    如果需要其他机制分配内存，则可以创建一个指针大小的userdata，在userdata中保存真正的内存地址

    例如 :
    a = (NumArray*)lua_newuserdata(L, nbytes);


    通过userdata的元表来区别不同的userdata。

    int luaL_newnetatable(L, strname); 创建元表，放入栈顶
    void luaL_getmetatable(L, strname);
    void *luaL_checkudata(L, index, strname) 检测指定位置上是否是uerdata，
        并且有 给定名称的元表
    通过元表来 区别 userdata：
    1、在注册函数中 创建元表
        extern "C" __declspec(dllexport)
        int luaopen_myarray(lua_State * L)
        {
            ...
            luaL_newmetatable(L, "LuaBook.myarray");
            ...
        }
    2、在创建数组时 设置元表
        //因为这里又入栈了一个table，所以 lua_setmetatable 的参数是 -2
        luaL_getmetatable(L, "LuaBook.myarray");
        lua_setmetatable(L, -2);
    3、通过函数来 检测是否是userdata和是否元表对的上
        (NumArray*)luaL_checkudata(L, 1, "LuaBook.myarray");


    将userdata变成对象
    __index 元方法，userdata没有key，所以每次访问时都会调用到它

    1 设置两个函数表
        static const struct luaL_Reg arraylib_f[] = {
            {"new", l_newarray},
            {NULL, NULL}
        };

        static const struct luaL_Reg arraylib_m[] = {
            {"set", l_setarray},
            {"get", l_getarray},
            {"size", l_getarraysize},
            {"__tostring", l_array2string},
            {NULL, NULL}
        };
    2 在luaopen_XXX中:
        luaL_newmetatable(L, "MyArray"); //创建元表
        lua_pushvalue(L, -1);   // 赋值元表，现在-1,-2 中全是table
        lua_setfield(L, -2, "__index"); //将 -2 中的__index 项设置为 -1中的tabele，即,tab.__index = tab;
        //如果NULL为库名，则注册的函数不在 函数table中，而在栈顶的table中
        luaL_register(L, NULL, arraylib_m); // 元方法的函数注册在 -1的表中
        luaL_register(L, "array", arraylib_f); //模块的函数
    3 在new中 还是要设置元表


    数组方式访问元素:
    static const struct luaL_Reg arraylib_m[] = {
        {"__newindex", l_setarray},
        {"__index", l_getarray},
        {"__len", l_getarraysize},
        {"__tostring", l_array2string},
        {NULL, NULL}
    };
    同一个方法 被多次注册：
        { "get", l_getarray },
        {"getvalue", l_getarray},
        { "__index", l_getarray },
        没有__index 时两个都能用，存在 __index时，只能用__index


    轻量级userdata 只存放了一个c指针，void*
    void lua_pushlightuserdata(lua_State* L, void*p)
    不接受 垃圾收集
    主要用途 相等性比较


]]