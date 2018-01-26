tab = {
    

}

function tab:init(num, str)
    print("init : ", num, str)
end

function tab.create(tab, num, str)
    print("create : ", num, str)
end

tab:init(12, "123")
tab.init(tab, 12, "123")

tab.create(tab, 23, "344");
tab:create(23, "344");

function test( ... )
    tab.init(tab, ...)
    tab.create(...);
end

test(12, "2323")