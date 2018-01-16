require "socket"



function download(host, file)
    local c = assert(socket.connect(host, 80));
    local count = 0;
    c:send("GET " .. file .. " HTTP/1.0\r\n\r\n");
    while true do
        local s, status, partial = receive(c)
        count = count + #(s or partial);
        if  status == "closed" then break; end
    end
    c:close();
    print(file, count)
end

--因为并发的时候不能堵塞，所以在没有可用的数据时挂起
-- function receive(connection)
--     return connection:receive(2^10);
-- end

function receive(connection)
    connection:settimeout(0); -- 使以后对此连接进行的操作不会堵塞
    local s, status, partial = connection:receive(2^10);
    if  status  == "timeout" then
        --返回 connection 是为了告诉调用者，这个线程尚未结束
        coroutine.yield(connection);
    end
    return s, status, partial;
end

threads = {};

function get(host, file)
    local co = coroutine.create(function ()
        download(host,file);
    end)
    table.insert(threads, co);
end

function dispatch()
    local i = 1;
    local connections = {};
    while   true do
        if  threads[i] == nil then
            if  threads[1] == nil then
                break;
            end
            i = 1;
            connections = {};
        end

        local status, res = coroutine.resume(threads[i]);
        if not res then
            table.remove(threads, i);
        else
            i = i + 1;
            connections[#connections + 1] = res;
            --这是为了避免:当所有线程都没有数据可读的时候，只会不停的切换监听各个线程，空耗cpu；
            --当发生这种状态时，调用 select 函数 来监测那个线程好了。
            if  #connections == #threads then
                socket.select(connections)
            end
        end
    end
end
host = "www.w3.org"
get(host, "/TR/html401/html40.txt")
get(host, "/TR/2002/REC-xhtml1-20020801/xhtml1.pdf")
get(host, "/TR/REC-html32.html")
get(host, "/TR/2000/REC-DOM-Level-2-Core-20001113/DOM2-Core.txt")

dispatch()