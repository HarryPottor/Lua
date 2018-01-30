require "Tool.Tool"
local SysLogin = require "Module.System.Login.SysLogin";

local login = SysLogin:Create();
local input = io.read();
while(input ~= nil) do
    if  input == "show" then
        login:show();
    elseif input == "hide" then
        login:hide();
    elseif input == "send" then
        login:SendToServer();
    elseif input == "quit" then
        break;
    end

    input = io.read();
end

