-- require "TestModule"
-- TestModule:showinfo(10, 12)

require "UIBase"
object = UIBase.Create(10, 20);
object2 = UIBase.Create(100, 200);
-- object:showPos()
-- object:showName()
-- object2:showPos()
-- object2:showName()

for k,v in pairs(object) do
    print(k,v)
end
