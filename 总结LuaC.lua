1 环境的搭建
    找到lua的include文件和lib文件，在vs中包含头文件路径中加入include，
    在包含库文件中加入lib，在input的导入库中加入lua51.lib。
    在C文件中加入头文件:
        extern "C" {
            #include "lua.h"
            #include "lauxlib.h"
            #include "lualib.h"
        }
        或者
        #include "lua.hpp"
2 创建和关闭lua状态:
    lua_State* lua_newstate() => lua_open()
    lua_close(L)

    lua_State* lua_newthread(L)

3 对栈的操作: 
int   (lua_gettop) (lua_State *L); //获取栈内数据个数
void  (lua_settop) (lua_State *L, int idx); //将idx置顶，多删少补nil
void  (lua_pushvalue) (lua_State *L, int idx); //将idx中的数据再次压入栈
void  (lua_remove) (lua_State *L, int idx); //删除idx中的数据，后边的数据往前补
void  (lua_insert) (lua_State *L, int idx); //在idx处插入数据
void  (lua_replace) (lua_State *L, int idx); //将栈顶元素放入index位置中，栈顶出栈
int   (lua_checkstack) (lua_State *L, int sz); //检查栈中是否能容下sz个参数

void  (lua_xmove) (lua_State *from, lua_State *to, int n); 将from中的n个数据出栈，
    到to栈中。

4   检测类型:
    int             (lua_isnumber) (lua_State *L, int idx);
    int             (lua_isstring) (lua_State *L, int idx);
    int             (lua_iscfunction) (lua_State *L, int idx);
    int             (lua_isuserdata) (lua_State *L, int idx);
    int             (lua_type) (lua_State *L, int idx);
    const char     *(lua_typename) (lua_State *L, int tp);
    进行比较:
    int            (lua_equal) (lua_State *L, int idx1, int idx2);
    int            (lua_rawequal) (lua_State *L, int idx1, int idx2);
    int            (lua_lessthan) (lua_State *L, int idx1, int idx2);
    获取栈中数据:
    lua_Number      (lua_tonumber) (lua_State *L, int idx);
    lua_Integer     (lua_tointeger) (lua_State *L, int idx);
    int             (lua_toboolean) (lua_State *L, int idx);
    const char     *(lua_tolstring) (lua_State *L, int idx, size_t *len);
    size_t          (lua_objlen) (lua_State *L, int idx); //idx数据有多长
    lua_CFunction   (lua_tocfunction) (lua_State *L, int idx);
    void           *(lua_touserdata) (lua_State *L, int idx);
    lua_State      *(lua_tothread) (lua_State *L, int idx);
    const void     *(lua_topointer) (lua_State *L, int idx);

5   C数据入栈
    void  (lua_pushnil) (lua_State *L);
    void  (lua_pushnumber) (lua_State *L, lua_Number n);
    void  (lua_pushinteger) (lua_State *L, lua_Integer n);
    void  (lua_pushlstring) (lua_State *L, const char *s, size_t l);
    void  (lua_pushstring) (lua_State *L, const char *s);
    const char *(lua_pushvfstring) (lua_State *L, const char *fmt,
                                                  va_list argp);
    const char *(lua_pushfstring) (lua_State *L, const char *fmt, ...);
    void  (lua_pushcclosure) (lua_State *L, lua_CFunction fn, int n);
    void  (lua_pushboolean) (lua_State *L, int b);
    void  (lua_pushlightuserdata) (lua_State *L, void *p);
    int   (lua_pushthread) (lua_State *L);

6   获取数据  与table相关
    void  (lua_gettable) (lua_State *L, int idx);
    void  (lua_getfield) (lua_State *L, int idx, const char *k);
    void  (lua_rawget) (lua_State *L, int idx);
    void  (lua_rawgeti) (lua_State *L, int idx, int n);
    void  (lua_createtable) (lua_State *L, int narr, int nrec);
    void *(lua_newuserdata) (lua_State *L, size_t sz);
    int   (lua_getmetatable) (lua_State *L, int objindex);
    void  (lua_getfenv) (lua_State *L, int idx);
    设置数据 
    LUA_API void  (lua_settable) (lua_State *L, int idx);
    LUA_API void  (lua_setfield) (lua_State *L, int idx, const char *k);
    LUA_API void  (lua_rawset) (lua_State *L, int idx);
    LUA_API void  (lua_rawseti) (lua_State *L, int idx, int n);
    LUA_API int   (lua_setmetatable) (lua_State *L, int objindex);
    LUA_API int   (lua_setfenv) (lua_State *L, int idx);

7   load 与 call 函数
    LUA_API void  (lua_call) (lua_State *L, int nargs, int nresults);
    LUA_API int   (lua_pcall) (lua_State *L, int nargs, int nresults, int errfunc);
    LUA_API int   (lua_cpcall) (lua_State *L, lua_CFunction func, void *ud);
    LUA_API int   (lua_load) (lua_State *L, lua_Reader reader, void *dt,
                                            const char *chunkname);

    LUA_API int (lua_dump) (lua_State *L, lua_Writer writer, void *data);

8   协同程序
    LUA_API int  (lua_yield) (lua_State *L, int nresults);
    LUA_API int  (lua_resume) (lua_State *L, int narg);
    LUA_API int  (lua_status) (lua_State *L);

    ---------------------------------------------------------------

9     快捷操作
#define lua_pop(L,n)        lua_settop(L, -(n)-1)

#define lua_newtable(L)     lua_createtable(L, 0, 0)

#define lua_register(L,n,f) (lua_pushcfunction(L, (f)), lua_setglobal(L, (n)))

#define lua_pushcfunction(L,f)  lua_pushcclosure(L, (f), 0)

#define lua_strlen(L,i)     lua_objlen(L, (i))

#define lua_isfunction(L,n) (lua_type(L, (n)) == LUA_TFUNCTION)
#define lua_istable(L,n)    (lua_type(L, (n)) == LUA_TTABLE)
#define lua_islightuserdata(L,n)    (lua_type(L, (n)) == LUA_TLIGHTUSERDATA)
#define lua_isnil(L,n)      (lua_type(L, (n)) == LUA_TNIL)
#define lua_isboolean(L,n)  (lua_type(L, (n)) == LUA_TBOOLEAN)
#define lua_isthread(L,n)   (lua_type(L, (n)) == LUA_TTHREAD)
#define lua_isnone(L,n)     (lua_type(L, (n)) == LUA_TNONE)
#define lua_isnoneornil(L, n)   (lua_type(L, (n)) <= 0)

#define lua_pushliteral(L, s)   \
    lua_pushlstring(L, "" s, (sizeof(s)/sizeof(char))-1)

#define lua_setglobal(L,s)  lua_setfield(L, LUA_GLOBALSINDEX, (s))
#define lua_getglobal(L,s)  lua_getfield(L, LUA_GLOBALSINDEX, (s))

#define lua_tostring(L,i)   lua_tolstring(L, (i), NULL)

#define lua_open()  luaL_newstate()

#define lua_getregistry(L)  lua_pushvalue(L, LUA_REGISTRYINDEX)

#define lua_getgccount(L)   lua_gc(L, LUA_GCCOUNT, 0)

#define lua_Chunkreader     lua_Reader
#define lua_Chunkwriter     lua_Writer


-----------------------------------------------------------------------------
LUALIB_API void (luaL_openlibs) (lua_State *L); 
LUALIB_API void (luaL_register) (lua_State *L, const char *libname,
                                const luaL_Reg *l);

//检测类型并返回
LUALIB_API const char *(luaL_checklstring) (lua_State *L, int numArg,
                                                          size_t *l);
LUALIB_API const char *(luaL_optlstring) (lua_State *L, int numArg,
                                          const char *def, size_t *l);
LUALIB_API lua_Number (luaL_checknumber) (lua_State *L, int numArg);
LUALIB_API lua_Number (luaL_optnumber) (lua_State *L, int nArg, lua_Number def);

LUALIB_API lua_Integer (luaL_checkinteger) (lua_State *L, int numArg);
LUALIB_API lua_Integer (luaL_optinteger) (lua_State *L, int nArg,
                                          lua_Integer def);
LUALIB_API void (luaL_checkstack) (lua_State *L, int sz, const char *msg);
LUALIB_API void (luaL_checktype) (lua_State *L, int narg, int t);
LUALIB_API void (luaL_checkany) (lua_State *L, int narg);

//加载文件 buffer string
LUALIB_API int (luaL_loadfile) (lua_State *L, const char *filename);
LUALIB_API int (luaL_loadbuffer) (lua_State *L, const char *buff, size_t sz,
                                  const char *name);
LUALIB_API int (luaL_loadstring) (lua_State *L, const char *s);

LUALIB_API lua_State *(luaL_newstate) (void);
LUALIB_API const char *(luaL_gsub) (lua_State *L, const char *s, const char *p,
                                                  const char *r);

LUALIB_API const char *(luaL_findtable) (lua_State *L, int idx,
                                         const char *fname, int szhint);

// dofile
#define luaL_typename(L,i)  lua_typename(L, lua_type(L,(i)))

#define luaL_dofile(L, fn) \
    (luaL_loadfile(L, fn) || lua_pcall(L, 0, LUA_MULTRET, 0))

#define luaL_dostring(L, s) \
    (luaL_loadstring(L, s) || lua_pcall(L, 0, LUA_MULTRET, 0))

#define luaL_getmetatable(L,n)  (lua_getfield(L, LUA_REGISTRYINDEX, (n)))


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