local func1 ;
func1 = function (num )
    if num == 0 then
        return 1;
    else
        return num* func1(num-1);
    end
end

print(func1(4))