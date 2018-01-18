str = "aabcbaabgeba"

for v in string.gmatch(str, "[ab][ab]") do
    print(v)
end

s, e = string.find(str, "[ab][ab]")
while s ~= nil do
    print(s,e,string.sub(str, s, e));
    s, e = string.find(str, "[ab][ab]", s+1)
end


s1="Harry"
s2="Lucy"

str = "Harry is good boy, Harry Love study"

str = string.gsub(str, s1, s2);
