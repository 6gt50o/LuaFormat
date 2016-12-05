
------------------------------------------------------------
-- Class
------------------------------------------------------------
function class()
    local cls = {}
    cls.__index = cls
    cls.__add = function(a, b)
            local btype = type(b)
            if btype == 'string' then
                a:concat(b)
            elseif btype == 'table' and type(b.repr) == 'string' then
                a:concat(b:get_string())
            end
            return a
        end
    cls.__tostring = function(t)
            return t.repr
        end

    function cls.new(...)
        local obj = setmetatable({}, cls)
        if obj.ctor then
            obj:ctor(...)
        end
        return obj
    end

    return cls
end

------------------------------------------------------------
-- Node
------------------------------------------------------------
local Node = class()

function Node:ctor(str, ctype)
    self._str  = str or ''
    self._type = ctype or 0 
end

function Node:get_type()
    return self._type
end

function Node:set_type(type)
    self._type = type
end

function Node:concat(c)
    if self._str == ' ' and c == ' ' then return end
    self._str = self._str .. c
end

function Node:get_string()
    return self._str
end

return Node
