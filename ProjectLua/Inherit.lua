fa = {
    posX = 100;
    posY = 200;
    setPos = function (x, y)
        posX = x;
        posY = y;
    end;

    showPos = function ()
        print(posX, posY);
    end
}


factory = {}
function factory:CreateSon(fa)
    local obj = {}
    setmetatable(obj, fa);
    fa.__index = fa;

    return obj;
end

obj1 = factory:CreateSon(fa);
obj2 = factory:CreateSon(fa);
print(obj1, obj2)

obj1.setPos(1,2)
obj2.setPos(10,20)

obj1.showPos()
obj2.showPos()
