
-- 如果不传入self，则当Account = nil时，a 调用add方法就会报错
--[[
Account = {balance = 0}

function Account.add(self , num )
    self.balance = self.balance  + num;
end

Account.add(Account, 100);

a = Account;
Account = nil;
a.add(a, 99)

--]]

-- . 方法 和  : 方法 可自由转换
--[[
account = {}
account.add = function (self,num)
    print(num)
end
function account:show()
    print "account"
end

account.show(self)
account:add(100)

--]]


-- 类
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

function Account:new(obj)
    obj = obj or {};
    setmetatable(obj, self);
    self.__index = self;
    return obj;
end

local acc = Account:new();
acc:deposit(100);
print(acc.balance);

--子类与覆盖
SubAccount = Account:new();

function SubAccount:withdraw(v)
    self.balance = self.balance - v * 2;
end

function SubAccount:deposit(v)
    self.balance = self.balance + v * 2;
end


subacc = SubAccount:new();

print(subacc.balance)
subacc:withdraw(100);
print(subacc.balance)