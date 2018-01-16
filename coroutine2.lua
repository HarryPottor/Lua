function send(num)
    print("------------------------------ yield1")
    ---------Value = coroutine.yield(num)
    -- coroutine.yield(num) 是上次执行的最后一步，将num传递出去
    -- Value 是新的起点，获取resume的参数。
    coroutine.yield(num);
    print("------------------------------ yield2")
end

function InputNumber() -----------------------------------------第一次启动的函数起点
    while true do
        print("------------------------------ InputNumber1")
        local num = io.read();
        send(num);
        print("------------------------------ InputNumber2", num)
    end
end

local co = coroutine.create(InputNumber)

function receive()
    print("------------------------------ resume1")
    local status, num = coroutine.resume(co);
    print("------------------------------ resume2")
    return num;
end

function ShowDouble()
    while true do
        local num = receive();
		if num then
			print("string = ", string.upper(num));
		end
    end
end

ShowDouble();




