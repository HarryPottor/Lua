#include <stdio.h>
#include <string.h>
#include "lua/lua.h"
#include "lua/lauxlib.h"
#include "lua/lualib.h"
#pragma comment(lib,"lua51.lib")
int main(void)
{
    char buff[256];
    int error;
    lua_State * L = lua_open();
    luaL_openlibs(L);

    while (fgets(buff, sizeof(buff), stdin)!=NULL)
    {
        error = luaL_loadbuffer(L, buff, strlen(buff), "line") || 
            lua_pcall(L, 0,0,0);
        if (error)
        {
            fprintf(stderr, "%s\n", lua_tostring(L, -1));
            lua_pop(L, 1);
        }
    }

    lua_close(L);

    return 0;
}