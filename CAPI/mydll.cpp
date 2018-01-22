#include <stdio.h>
#include <string.h>
#include "lua.hpp"
#include <math.h>
#include <ctype.h>

static int l_sin(lua_State* L)
{
	double num = luaL_checknumber(L, 1);
	lua_pushnumber(L, num*2);
	return 1;
}

static int add(lua_State* L)
{
	double op1 = luaL_checknumber(L, 1);
	double op2 = luaL_checknumber(L, 2);
	lua_pushnumber(L, op1 + op2);
	return 1;
}

static int l_map(lua_State * L)
{
	int i, n;
	luaL_checktype(L, 1, LUA_TTABLE);
	luaL_checktype(L, 2, LUA_TFUNCTION);

	n = lua_objlen(L, 1);

	for (i = 1; i <= n; i++)
	{
		lua_pushvalue(L, 2);
		lua_rawgeti(L, 1, i);
		lua_call(L, 1, 1);
		lua_rawseti(L, 1, i);
	}

	return 0;
}

static int l_split(lua_State* L)
{
	const char* s = luaL_checkstring(L, 1);
	const char* sep = luaL_checkstring(L, 2);
	const char * e;
	int i = 1;

	lua_newtable(L);

	while ((e = strchr(s,*sep)) != NULL)
	{
		lua_pushlstring(L, s, e - s);
		lua_rawseti(L, -2, i++);
		s = e + 1;
	}

	lua_pushstring(L, s);
	lua_rawseti(L, -2, i);

	return 1;
}

static int l_strconnect(lua_State* L)
{
	int count = luaL_checkint(L, 1);
	lua_concat(L, count);
	int len = lua_objlen(L, -1);
	lua_pushnumber(L, len);
	return 2;
}

static int l_pushfstring(lua_State* L)
{
	const char* fmt = luaL_checkstring(L, 1);
	int count = luaL_checkint(L, 2);
	switch (count)
	{
	case 1:
	{
		const char* arg1 = lua_tostring(L, 3);
		lua_pushfstring(L, fmt, arg1);
		break;
	}
	case 2:
	{
		const char* arg1 = lua_tostring(L, 3);
		const char* arg2 = lua_tostring(L, 4);
		lua_pushfstring(L, fmt, arg1, arg2);
		break;
	}
	case 3:
	{
		const char* arg1 = lua_tostring(L, 3);
		const char* arg2 = lua_tostring(L, 4);
		const char* arg3 = lua_tostring(L, 5);
		//luaL_error(L, "info:%s, %s, %s", arg1, arg2, arg3);
		lua_pushfstring(L, fmt, arg1, arg2, arg3);
		break;
	}
	case 4:
	{
		const char* arg1 = lua_tostring(L, 3);
		const char* arg2 = lua_tostring(L, 4);
		const char* arg3 = lua_tostring(L, 5);
		const char* arg4 = lua_tostring(L, 6);
		lua_pushfstring(L, fmt, arg1, arg2, arg3, arg4);
		break;
	}
	}
			
	return 1;
}

static int l_strupper(lua_State* L)
{
	size_t l;
	size_t i;
	luaL_Buffer b;
	const char *s = luaL_checklstring(L, 1, &l);
	luaL_buffinit(L, &b);
	for (i = 0; i < l; i++)
	{
		luaL_addchar(&b, toupper((unsigned char)(s[i])));
	}
	luaL_pushresult(&b);

	return 1;
}

static luaL_Reg mylib[] = 
{
	{ "myadd", add },
	{ "mysin", l_sin },
	{ "mysplit", l_split },
	{ "mystrconnect", l_strconnect },
	{ "mypushfstring", l_pushfstring },
	{ "mystrupper", l_strupper },
	{NULL, NULL}
};


extern "C" __declspec(dllexport)
int luaopen_mydll(lua_State * L)
{
	luaL_register(L, "mydll", mylib);
	return 1;
}