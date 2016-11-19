
------------------------------------------------------------
-- Class
------------------------------------------------------------
function class(super)
    local obj = {}
    obj.__index = obj
    -- obj.__add = function(a, b)
    --         if type(b) == 'string' then a.repr = a.repr .. b end
    --         if type(b) == 'table' and type(b.repr) == 'string' then a.repr = a.repr .. b.repr end
    --         return a
    --     end
    -- obj.__tostring = function(t)
    --         return t.repr
    --     end

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
-- Line
------------------------------------------------------------

local Line = class()

function Line:ctor()
    self.node_list = {}
end

function Line:concat(node)
end

return Line