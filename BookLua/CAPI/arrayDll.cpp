#include <stdio.h>
#include <string.h>
#include "lua.hpp"
#include <math.h>
#include <ctype.h>
#include <limits.h>


//比如说 一个无符号整型 4个字节，共有32位； 字3字2字1==32位32位32位
// 每一位可以表示一个bool值
// 索引10 的 I_WORD 是 0 ，所以保存在0字中
// 索引10 的 I_BIT 是 10， 所以掩码为100 0000 0000，用这个值与原值与，即为结果

//一个无符号整型的 bit数量
#define BITS_PER_WORD (CHAR_BIT*sizeof(unsigned int))
//通过给定的索引 计算对应 bit位存放的 字
#define I_WORD(i) ((unsigned int)(i)/BITS_PER_WORD)
// 计算出一个掩码，用于访问这个word中的正确bit
#define I_BIT(i) (1 << ((unsigned int)(i) % BITS_PER_WORD))

typedef struct NumArray
{
	int size;
	unsigned int values[1]; //可扩展

} NumArray;


#define checkarray(L) (NumArray*)luaL_checkudata(L, 1, "MyArray");


static int l_newarray(lua_State* L)
{
	int i, n;
	size_t nbytes;
	NumArray* a;

	n = luaL_checkint(L, 1);
	luaL_argcheck(L, n >= 1, 1, "invalid size");
	// 通过 元素个数 n 计算有多少字节s
	//		结构体的字节数(size的大小和一个unsigned的大小) + n个元素占的字*每个字的大小
	//		为什么 n -1 ？因为数组大小中 已经有一个字的大小了
	nbytes = sizeof(NumArray) + I_WORD(n - 1) * sizeof(unsigned int);
	a = (NumArray*)lua_newuserdata(L, nbytes);

	a->size = n;
	for (i = 0; i <= I_WORD(n - 1); i++)
	{
		a->values[i] = 0;
	}
	
	//因为这里又入栈了一个table，所以 lua_setmetatable 的参数是 -2
	luaL_getmetatable(L, "MyArray");
	lua_setmetatable(L, -2);
	return 1;
}

static int l_setarray(lua_State* L)
{
	NumArray * a = checkarray(L); //(NumArray*)lua_touserdata(L, 1);
	int index = luaL_checkint(L, 2) - 1;
	luaL_checkany(L, 3);
	luaL_argcheck(L, a != NULL, 1, "array expected");
	luaL_argcheck(L, 0 <= index && index < a->size, 2, "index out of range");

	if (lua_toboolean(L, 3))
	{
		a->values[I_WORD(index)] |= I_BIT(index);
	}
	else
	{
		a->values[I_WORD(index)] &= ~I_BIT(index);
	}

	return 0;
}

static int l_getarray(lua_State* L)
{
	NumArray* a = checkarray(L);// (NumArray*)lua_touserdata(L, 1);
	int index = luaL_checkint(L, 2) - 1;
	luaL_argcheck(L, a != NULL, 1, "array expected");
	luaL_argcheck(L, 0 <= index && index < a->size, 2, "index out of range");

	lua_pushboolean(L, a->values[I_WORD(index)] & I_BIT(index));
	return 1;
}

static int l_getarraysize(lua_State* L)
{
	NumArray* a = (NumArray*)lua_touserdata(L, 1);
	luaL_argcheck(L, a != NULL, 1, "array expected");
	lua_pushinteger(L, a->size);
	return 1;
}

static int l_array2string(lua_State* L)
{
	NumArray* a = checkarray(L);
	lua_pushfstring(L, "array(%d)", a->size);
	return 1;
}

/*
static luaL_Reg mylib[] =
{
	{ "mynewarray", l_newarray },
	{ "mysetarray", l_setarray },
	{ "mygetarray", l_getarray },
	{ "mygetarraysize", l_getarraysize },

	{ NULL, NULL }
};


extern "C" __declspec(dllexport)
int luaopen_myarray(lua_State * L)
{
	luaL_newmetatable(L, "LuaBook.myarray");
	luaL_register(L, "myarray", mylib);
	return 1;
}

*/

static const struct luaL_Reg arraylib_f[] = {
	{"new", l_newarray},
	{NULL, NULL}
};

static const struct luaL_Reg arraylib_m[] = {
	{"__newindex", l_setarray},
	{ "get", l_getarray },
	{"getvalue", l_getarray},
	{"__len", l_getarraysize},
	{"__tostring", l_array2string},
	{NULL, NULL}
};

extern "C" __declspec(dllexport)
int luaopen_array(lua_State * L)
{
	luaL_newmetatable(L, "MyArray");
	lua_pushvalue(L, -1);
	lua_setfield(L, -2, "__index");
	//如果NULL为库名，则注册的函数不在 函数table中，而在栈顶的table中
	luaL_register(L, NULL, arraylib_m);
	luaL_register(L, "array", arraylib_f);

	return 1;
}
