// #include <stdio.h>
// #include <string.h>
// #include "lua.hpp"
// #include <math.h>
// #include <ctype.h>
// #include <limits.h>
// 
// 
// //比如说 一个无符号整型 4个字节，共有32位； 字3字2字1==32位32位32位
// // 每一位可以表示一个bool值
// // 索引10 的 I_WORD 是 0 ，所以保存在0字中
// // 索引10 的 I_BIT 是 10， 所以掩码为100 0000 0000，用这个值与原值与，即为结果
// 
// //一个无符号整型的 bit数量
// #define BITS_PER_WORD (CHAR_BIT*sizeof(unsigned int))
// //通过给定的索引 计算对应 bit位存放的 字
// #define I_WORD(i) ((unsigned int)(i)/BITS_PER_WORD)
// // 计算出一个掩码，用于访问这个word中的正确bit
// #define I_BIT(i) (1 << ((unsigned int)(i) % BITS_PER_WORD))
// 
// typedef struct NumArray
// {
// 	int size;
// 	unsigned int values[1]; //可扩展
// 
// } NumArray;
// 
// static int l_newarray(lua_State* L)
// {
// 	int i, n;
// 	size_t nbytes;
// 	NumArray* a;
// 
// 	n = luaL_checkint(L, 1);
// 	luaL_argcheck(L, n >= 1, 1, "invalid size");
// 	// 通过 元素个数 n 计算有多少字节s
// 	//		结构体的字节数(size的大小和一个unsigned的大小) + n个元素占的字*每个字的大小
// 	//		为什么 n -1 ？因为数组大小中 已经有一个字的大小了
// 	nbytes = sizeof(NumArray) + I_WORD(n - 1) * sizeof(unsigned int);
// 	a = (NumArray*)lua_newuserdata(L, nbytes);
// 
// 	a->size = n;
// 	for (i = 0; i <= I_WORD(n-1); i++)
// 	{
// 		a->values[i] = 0;
// 	}
// 
// 	return 1;
// }
// 
// static int l_setarray(lua_State* L)
// {
// 	NumArray * a = (NumArray*)lua_touserdata(L, 1);
// 	int index = luaL_checkint(L, 2) - 1;
// 	luaL_checkany(L, 3);
// 	luaL_argcheck(L, a != NULL, 1, "array expected");
// 	luaL_argcheck(L, 0 <= index && index < a->size, 2, "index out of range");
// 
// 	if (lua_toboolean(L, 3))
// 	{
// 		a->values[I_WORD(index)] |= I_BIT(index);
// 	}
// 	else
// 	{
// 		a->values[I_WORD(index)] &= ~I_BIT(index);
// 	}
// 
// 	return 0;
// }
// 
// static int l_getarray(lua_State* L)
// {
// 	NumArray* a = (NumArray*)lua_touserdata(L, 1);
// 	int index = luaL_checkint(L, 2) - 1;
// 	luaL_argcheck(L, a != NULL, 1, "array expected");
// 	luaL_argcheck(L, 0 <= index && index < a->size, 2, "index out of range");
// 
// 	lua_pushboolean(L, a->values[I_WORD(index)] & I_BIT(index));
// 	return 1;
// }
// 
// static int l_getarraysize(lua_State* L)
// {
// 	NumArray* a = (NumArray*)lua_touserdata(L, 1);
// 	luaL_argcheck(L, a != NULL, 1, "array expected");
// 	lua_pushinteger(L, a->size);
// 	return 1;
// }
// 
// static int l_sin(lua_State* L)
// {
// 	double num = luaL_checknumber(L, 1);
// 	lua_pushnumber(L, num*2);
// 	return 1;
// }
// 
// static int add(lua_State* L)
// {
// 	double op1 = luaL_checknumber(L, 1);
// 	double op2 = luaL_checknumber(L, 2);
// 	lua_pushnumber(L, op1 + op2);
// 	return 1;
// }
// 
// static int l_map(lua_State * L)
// {
// 	int i, n;
// 	luaL_checktype(L, 1, LUA_TTABLE);
// 	luaL_checktype(L, 2, LUA_TFUNCTION);
// 
// 	n = lua_objlen(L, 1);
// 
// 	for (i = 1; i <= n; i++)
// 	{
// 		lua_pushvalue(L, 2);
// 		lua_rawgeti(L, 1, i);
// 		lua_call(L, 1, 1);
// 		lua_rawseti(L, 1, i);
// 	}
// 
// 	return 0;
// }
// 
// static int l_split(lua_State* L)
// {
// 	const char* s = luaL_checkstring(L, 1);
// 	const char* sep = luaL_checkstring(L, 2);
// 	const char * e;
// 	int i = 1;
// 
// 	lua_newtable(L);
// 
// 	while ((e = strchr(s,*sep)) != NULL)
// 	{
// 		lua_pushlstring(L, s, e - s);
// 		lua_rawseti(L, -2, i++);
// 		s = e + 1;
// 	}
// 
// 	lua_pushstring(L, s);
// 	lua_rawseti(L, -2, i);
// 
// 	return 1;
// }
// 
// static int l_strconnect(lua_State* L)
// {
// 	int count = luaL_checkint(L, 1);
// 	lua_concat(L, count);
// 	int len = lua_objlen(L, -1);
// 	lua_pushnumber(L, len);
// 	return 2;
// }
// 
// static int l_pushfstring(lua_State* L)
// {
// 	const char* fmt = luaL_checkstring(L, 1);
// 	int count = luaL_checkint(L, 2);
// 	switch (count)
// 	{
// 	case 1:
// 	{
// 		const char* arg1 = lua_tostring(L, 3);
// 		lua_pushfstring(L, fmt, arg1);
// 		break;
// 	}
// 	case 2:
// 	{
// 		const char* arg1 = lua_tostring(L, 3);
// 		const char* arg2 = lua_tostring(L, 4);
// 		lua_pushfstring(L, fmt, arg1, arg2);
// 		break;
// 	}
// 	case 3:
// 	{
// 		const char* arg1 = lua_tostring(L, 3);
// 		const char* arg2 = lua_tostring(L, 4);
// 		const char* arg3 = lua_tostring(L, 5);
// 		//luaL_error(L, "info:%s, %s, %s", arg1, arg2, arg3);
// 		lua_pushfstring(L, fmt, arg1, arg2, arg3);
// 		break;
// 	}
// 	case 4:
// 	{
// 		const char* arg1 = lua_tostring(L, 3);
// 		const char* arg2 = lua_tostring(L, 4);
// 		const char* arg3 = lua_tostring(L, 5);
// 		const char* arg4 = lua_tostring(L, 6);
// 		lua_pushfstring(L, fmt, arg1, arg2, arg3, arg4);
// 		break;
// 	}
// 	}
// 			
// 	return 1;
// }
// 
// static int l_strupper(lua_State* L)
// {
// 	size_t l;
// 	size_t i;
// 	luaL_Buffer b;
// 	const char *s = luaL_checklstring(L, 1, &l);
// 	luaL_buffinit(L, &b);
// 	for (i = 0; i < l; i++)
// 	{
// 		luaL_addchar(&b, toupper((unsigned char)(s[i])));
// 	}
// 	luaL_pushresult(&b);
// 
// 	return 1;
// }
// 
// static int l_settable(lua_State* L)
// {
// 	int index = luaL_checkint(L, 2);
// 	lua_rawseti(L, 1, index);
// 	return 0;
// }
// 
// static int l_gettable(lua_State* L)
// {
// 	int index = luaL_checkint(L, 2);
// 	lua_rawgeti(L, 1, index);
// 	return 1;
// }
// 
// 
// 
// static luaL_Reg mylib[] = 
// {
// 	{ "myadd", add },
// 	{ "mysin", l_sin },
// 	{ "mysplit", l_split },
// 	{ "mystrconnect", l_strconnect },
// 	{ "mypushfstring", l_pushfstring },
// 	{ "mystrupper", l_strupper },
// 	{ "mygettable", l_gettable },
// 	{ "mysettable", l_settable },
// 	{ "mynewarray", l_newarray },
// 	{ "mysetarray", l_setarray},
// 	{ "mygetarray", l_getarray},
// 	{ "mygetarraysize", l_getarraysize},
// 
// 	{NULL, NULL}
// };
// 
// 
// extern "C" __declspec(dllexport)
// int luaopen_mydll(lua_State * L)
// {
// 	luaL_register(L, "mydll", mylib);
// 	return 1;
// }