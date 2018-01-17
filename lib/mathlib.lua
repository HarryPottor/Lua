local deg, rad =math.deg, math.rad

local sin, asin = math.sin, math.asin



print(rad(90))
print(deg(3.14))

print(sin(rad(30)))


math.sin = function (degree)
    return sin(rad(degree))
end

print(math.sin(30))

local random = math.random;
math.randomseed(os.time())
print(os.time())
for i=1,10 do
    print("----------------------------------")
    print(random())
    print(random(6))
    print(random(6, 10))
end