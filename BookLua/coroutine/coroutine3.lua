co = coroutine.create(function ()
    for i=1,10 do
        print("yield:", coroutine.yield(i));
    end
end)

for i=100,110 do
    print("resume:", coroutine.resume(co, i));
end