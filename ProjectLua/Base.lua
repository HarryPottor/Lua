require "Class"

-- module(..., package.seeall)

Base = NewClass("Base");

function Base:Init(name, age)
    self.name = name;
    self.age = age;
end

function Base:ShowSelf()
    print(self.name, self.age, Base.name, Base.age);
end

return Base;
