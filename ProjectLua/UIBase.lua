Base = require "Base"

UIBase = NewClass("UIBase", Base);

function UIBase:Init(uiname, age)
    Base.Init(self, uiname, age);
    self.data = 0;
end

function UIBase:setData(num)
    self.data = num;
end

function UIBase:getData(num)
    return self.data;
end

function UIBase:draw()
    print(self.name)
end

function UIBase:showAll()
    print()
end

return UIBase;