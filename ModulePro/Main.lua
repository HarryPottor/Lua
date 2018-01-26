require "Tool.Tool"
local UIManager = require "Module.UI.UIManager"
local SystemManager = require "Module.System.SystemManager"


local objUI = UIManager:Create();

local objSys = SystemManager:Create(objUI);

objUI:SetData("Lucy", "This is a girl!", 12);
objSys:SendToServer();