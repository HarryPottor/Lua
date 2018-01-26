Tool = ...
local M = {}
_G[Tool] = M;

local print = _G.print;
local pairs = _G.pairs;
package.loaded[Tool] = M;

setfenv(1, M)

function showTable(tab)
    for k, v in pairs(tab) do
        print(k,v)
    end
end
