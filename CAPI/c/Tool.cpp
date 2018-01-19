#include "Tool.h"
#include <stdarg.h>
/*
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
 lua_getfield(L, -1, key)
	=> lua_pushstring(L, "key");
	=> lua_gettable(L, -2)
//这样操作，将获取的值放在 -1，table 放在了 -2；取值之后要出栈-1； 
	lua_pop(L, 1); 也就是lua_settop(L, -2)

//设置table 

 */


void stackDump(lua_State* L)
{
	int i;
	int top = lua_gettop(L);
	for (i = 1; i <= top; i++)
	{
		int t = lua_type(L, i);
		switch (t)
		{
		case LUA_TSTRING:
		{
			printf("'%s'", lua_tostring(L, i));
			break;
		}
		case LUA_TBOOLEAN:
		{
			printf(lua_toboolean(L, i)? "true" : "false");
			break;
		}
		case LUA_TNUMBER:
		{
			printf("%g", lua_tonumber(L, i));
			break;
		}

		default:
		{
			printf("%s", lua_typename(L, t));
			break;
		}
		}

		printf("   ");
	}
	printf("\n");

}

void Jieshiqi()
{
	char buff[256];
	int error;
	lua_State * L = lua_open();
	luaL_openlibs(L);
	int temp = 10000;
	//确保栈上有temp个空间,如果能为1，不能为0
	int sz = lua_checkstack(L, temp);
	printf("sz = %d, temp = %d", sz, temp);
	while (fgets(buff, sizeof(buff), stdin) != NULL)
	{
		error = luaL_loadbuffer(L, buff, strlen(buff), "line") ||
			lua_pcall(L, 0, 0, 0);
		if (error)
		{
			fprintf(stderr, "%s\n", lua_tostring(L, -1));
			lua_pop(L, 1);
		}
	}
	lua_close(L);
}

void testFunc()
{
	lua_State* L = lua_open();
	lua_pushboolean(L, 1);
	lua_pushnumber(L, 10);
	lua_pushnil(L);
	lua_pushstring(L, "hello");

	stackDump(L);

	printf("-----------lua_pushvalue-------------------");
	lua_pushvalue(L, -4);
	stackDump(L);

	printf("-----------lua_replace-------------------");
	lua_replace(L, 3);
	stackDump(L);

	printf("-----------lua_settop-------------------");
	lua_settop(L, 6);
	stackDump(L);

	printf("-----------lua_remove-------------------");
	lua_remove(L, -3);
	stackDump(L);

	printf("-----------lua_settop-------------------");
	lua_settop(L, -5);
	stackDump(L);

	lua_close(L);
}

//call_va("f", "dd>d", x, y, &z);
void call_va(lua_State* L, char* func, const char*sig, ...)
{
	va_list vl;
	int narg, nres;

	va_start(vl, sig);

	lua_getglobal(L, func);

	for (narg = 0; *sig; narg++)
	{
		luaL_checkstack(L, 1, "too many arguments");
		switch (*sig++)
		{
		case 'd':
			lua_pushnumber(L, va_arg(vl, double));
			break;
		case 'i':
			lua_pushinteger(L, va_arg(vl, int));
			break;
		case 's':
			lua_pushstring(L, va_arg(vl, char*));
			break;
		case '>':
			goto endargs;
			break;
		default:
			luaL_error(L, "invalid option");

		}
	}
endargs:
	nres = strlen(sig);
	if (lua_pcall(L, narg, nres, 0) != 0)
	{
		luaL_error(L, "error calling");
	}

	nres = -nres;
	while (*sig)
	{
		switch (*sig++)
		{
		case 'd':
		{
			if (!lua_isnumber(L, nres))
			{
				luaL_error(L, "error return");
			}
			*va_arg(vl, double*) = lua_tonumber(L, nres);
			break;
		}
		case 'i':
		{
			if (!lua_isnumber(L, nres))
			{
				luaL_error(L, "error return");
			}
			*va_arg(vl, int*) = lua_tointeger(L, nres);
			break;
		}
		case 's':
		{
			if (!lua_isnumber(L, nres))
			{
				luaL_error(L, "error return");
			}
			*va_arg(vl, const char**) = lua_tostring(L, nres);
			break;
		}
		default:
			luaL_error(L, "invalid option");
		}

		nres++;
	}

	va_end(vl);
}
