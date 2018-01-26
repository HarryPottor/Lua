#include <stdio.h>
#include <string.h>
#include "lua.hpp"
#include "Tool.h"

void load(lua_State* L, const char* fname, int * w, int * h)
{
	if (luaL_dofile(L, fname))
	{
		luaL_error(L, "connot run config. file: %s", lua_tostring(L, -1));
	}

	lua_getglobal(L, "width");
	lua_getglobal(L, "height");

	if (!lua_isnumber(L, -2))
	{
		luaL_error(L, "width should be a number\n");
	}

	if (!lua_isnumber(L, -1))
	{
		luaL_error(L, "height should be a number\n");
	}

	*w = lua_tointeger(L, -2);
	*h = lua_tointeger(L, -1);
}
#define  MAX_COLOR 255
struct ColorTable
{
	char* name;
	unsigned char red, green, blue;
};
int getfield(lua_State* L, const char* key)
{
	printf("---------------------------------\n");
	stackDump(L);
	int result;
	lua_pushstring(L, key);
	stackDump(L);
	lua_gettable(L, -2);
	stackDump(L);
	if (!lua_isnumber(L, -1))
	{
		luaL_error(L, "invalid component in background color");
	}
	result = (int)lua_tonumber(L, -1) * MAX_COLOR;
	stackDump(L);
	lua_pop(L, 1);
	stackDump(L);
	return result;
}

void setfield(lua_State* L, const char* index, int value)
{
	lua_pushstring(L, index);
	lua_pushnumber(L, (double)value / MAX_COLOR);
	lua_settable(L, -3); //将上边的key，value 设置进table后，弹出kv
	//或者调用 lua_setfield(L, -2, index)

}

void setcolor(lua_State * L, struct ColorTable* ct)
{
	lua_newtable(L);
	setfield(L, "r", ct->red);
	setfield(L, "g", ct->green);
	setfield(L, "b", ct->blue);
	lua_setglobal(L, ct->name);
}

void ValueAndTable()
{
	int width = 0;
	int height = 0;
	char* filename = "Config/config.lua";
	lua_State* L = lua_open();
	luaL_openlibs(L);
	// 获取全局的数据
	load(L, filename, &width, &height);

	//获取全局的表
	lua_getglobal(L, "background");
	if (!lua_istable(L, -1))
	{
		luaL_error(L, "'background' is not a table");
	}
	lua_getfield(L, -1, "r");
	int red = (int)lua_tonumber(L, -1) * MAX_COLOR;
	lua_pop(L, 1);
	lua_getfield(L, -1, "g");
	int green = (int)lua_tonumber(L, -1) * MAX_COLOR;
	lua_pop(L, 1);
	lua_getfield(L, -1, "b");
	int blue = (int)lua_tonumber(L, -1) * MAX_COLOR;
	lua_pop(L, 1);
	// 	int red = getfield(L, "r");
	// 	int green = getfield(L, "g");
	// 	int blue = getfield(L, "b");

	printf("%d-%d-%d\n", red, green, blue);

	// 将table写入L

	struct ColorTable colortable[] = {
		{ "WHITE", MAX_COLOR, MAX_COLOR, MAX_COLOR },
		{ "RED", MAX_COLOR, 0, 0 },
		{ "BLUE", 0, 0, MAX_COLOR },
		{ "GREEN", 0, MAX_COLOR, 0 },
		{ NULL, 0, 0, 0 },
	};

	int i = 0;
	while (colortable[i].name != NULL)
	{
		setcolor(L, &colortable[i++]);
	}

	//获取L中的数据
	lua_settop(L, 0);
	printf("---------init-------");
	stackDump(L);

	lua_getglobal(L, "WHITE");
	if (!lua_istable(L, -1))
	{
		luaL_error(L, "'WHITE' is not a table");
	}
	printf("---------start-------");
	stackDump(L);
	lua_getfield(L, -1, "r");
	printf("---------red-------");
	stackDump(L);
	int w_red = (int)lua_tonumber(L, -1) * MAX_COLOR;
	printf("---------red-------");
	stackDump(L);
	lua_settop(L, -2);
	printf("---------red-------");
	stackDump(L);

	lua_getfield(L, -1, "g");
	int w_green = (int)lua_tonumber(L, -1) * MAX_COLOR;
	lua_settop(L, -2);

	lua_getfield(L, -1, "b");
	int w_blue = (int)lua_tonumber(L, -1) * MAX_COLOR;
	lua_settop(L, -2);

	printf("%d-%d-%d\n", w_red, w_green, w_blue);
}

double func(lua_State*L, double x, double y)
{
	double z;

	lua_getglobal(L, "func");
	lua_pushnumber(L, x);
	lua_pushnumber(L, y);

	if (lua_pcall(L, 2, 1, 0))
	{
		puts("lua_pcall error");
		return -1;
	}

	if (!lua_isnumber(L, -1))
	{
		puts("lua return error");
		return - 2;
	}
	z = lua_tonumber(L, -1);
	lua_pop(L, 1);
	return z;
}

int main3()
{
	lua_State* L = lua_open();
	luaL_openlibs(L);
	if (luaL_dofile(L, "Config/config.lua"))
	{
		printf("error lua_dofile");
		return -1;
	}

	//double res = func(L, 2.0, 3.0);
	double x = 2.0;
	double y = 3.0;
	double z;
	call_va(L, "func", "dd>z", x,y, &z);

	printf("z = %f \n", z);

	lua_close(L);
	getchar();
	return 0;
}