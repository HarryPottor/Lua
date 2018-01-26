#include <stdio.h>
#include <string.h>
#include "lua.hpp"
#include <math.h>
#include <ctype.h>
#include <limits.h>


//����˵ һ���޷������� 4���ֽڣ�����32λ�� ��3��2��1==32λ32λ32λ
// ÿһλ���Ա�ʾһ��boolֵ
// ����10 �� I_WORD �� 0 �����Ա�����0����
// ����10 �� I_BIT �� 10�� ��������Ϊ100 0000 0000�������ֵ��ԭֵ�룬��Ϊ���

//һ���޷������͵� bit����
#define BITS_PER_WORD (CHAR_BIT*sizeof(unsigned int))
//ͨ������������ �����Ӧ bitλ��ŵ� ��
#define I_WORD(i) ((unsigned int)(i)/BITS_PER_WORD)
// �����һ�����룬���ڷ������word�е���ȷbit
#define I_BIT(i) (1 << ((unsigned int)(i) % BITS_PER_WORD))

typedef struct NumArray
{
	int size;
	unsigned int values[1]; //����չ

} NumArray;


#define checkarray(L) (NumArray*)luaL_checkudata(L, 1, "MyArray");


static int l_newarray(lua_State* L)
{
	int i, n;
	size_t nbytes;
	NumArray* a;

	n = luaL_checkint(L, 1);
	luaL_argcheck(L, n >= 1, 1, "invalid size");
	// ͨ�� Ԫ�ظ��� n �����ж����ֽ�s
	//		�ṹ����ֽ���(size�Ĵ�С��һ��unsigned�Ĵ�С) + n��Ԫ��ռ����*ÿ���ֵĴ�С
	//		Ϊʲô n -1 ����Ϊ�����С�� �Ѿ���һ���ֵĴ�С��
	nbytes = sizeof(NumArray) + I_WORD(n - 1) * sizeof(unsigned int);
	a = (NumArray*)lua_newuserdata(L, nbytes);

	a->size = n;
	for (i = 0; i <= I_WORD(n - 1); i++)
	{
		a->values[i] = 0;
	}
	
	//��Ϊ��������ջ��һ��table������ lua_setmetatable �Ĳ����� -2
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
	//���NULLΪ��������ע��ĺ������� ����table�У�����ջ����table��
	luaL_register(L, NULL, arraylib_m);
	luaL_register(L, "array", arraylib_f);

	return 1;
}
