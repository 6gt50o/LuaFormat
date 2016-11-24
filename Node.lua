
------------------------------------------------------------
-- Class
------------------------------------------------------------
function class(super)
    local obj = {}
    obj.__index = obj
    obj.__add = function(a, b)
            if type(b) == 'string' then a.repr = a.repr .. b end
            if type(b) == 'table' and type(b.repr) == 'string' then a.repr = a.repr .. b.repr end
            return a
        end
    obj.__tostring = function(t)
            return t.repr
        end

    setmetatable(obj, super)

    function obj.new(...)
        local instance = setmetatable({}, obj)
        if instance.ctor then
            instance:ctor(...)
        end
        return instance
    end

    return obj
end

------------------------------------------------------------
-- Node
------------------------------------------------------------
local Node = class()

function Node:ctor(repr)
    self.repr = repr or ''
    self.type = 0
end

function Node:get_type()
    return self.type
end

function Node:set_type(type)
    self.type = type
end

function Node:concat(c)
    if self.repr == ' ' and c == ' ' then return end
    self.repr = self.repr .. c
end

return Node
