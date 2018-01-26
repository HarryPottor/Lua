local function search(k, plist)
    for i = 1, #plist do
        local v = plist[i][k];
        if v then
            return v;
        end
    end
end

function createClass( ... )
    local c = {};
    local parents = {...};

    setmetatable(c, {__index = function (t, k)
        return search(k, parents)
    end})

    c.__index = c;

    function c:new(obj)
        obj = obj or {};
        setmetatable(obj, c)
        return obj;
    end

    return c;
end

-------------------------------------------------

Account = {
    balance = 0;
    withdraw = function (self, v)
        self.balance = self.balance - v;
    end;
    deposit = function (self, v)
        self.balance = self.balance + v;
    end;
    Data = {
        money = 0;
        time = "2018.1.17"
    }
}

Named = {}
function Named:getname()
    return self.name;
end
function Named:setname(n)
    self.name = n;
end


NameAccount = createClass(Account, Named);

newacc = NameAccount:new({name = "paul"})
print(newacc:getname(), newacc.balance)