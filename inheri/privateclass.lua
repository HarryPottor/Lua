
function AccountNew(money)
    local self = {balance = money, name = ""};
    local function withdraw(v)
        self.balance = self.balance - v;
    end
    local function getbalance()
        return self.balance;
    end

    return {
        withdraw = withdraw;
        getbalance = getbalance;
    }
end

obj = AccountNew(100);
obj.withdraw(10);
print(obj.getbalance())