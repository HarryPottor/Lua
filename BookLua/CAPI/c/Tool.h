#ifndef __TOOL_CPP__
#define __TOOL_CPP__
#include <stdio.h>
#include <string.h>
#include "lua.hpp"

void stackDump(lua_State* L);
void call_va(lua_State* L, char* func, const char*sig, ...);
#endif
