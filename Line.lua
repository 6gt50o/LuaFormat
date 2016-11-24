
require('common')

------------------------------------------------------------
-- Class
------------------------------------------------------------
function class(super)
    local obj = {}
    obj.__index    = obj
    obj.__tostring = function(t)
        return table.concat(t.node_list)
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
-- Line
------------------------------------------------------------

local Line = class()

function Line:ctor()
    self.node_list = {}
end

function Line:push(node)
    if node == nil then return end
    if #self.node_list == 0 and node:get_type() == NODE_TYPE_KEY.BLANK then return end
    table.insert(self.node_list, tostring(node))
end

function Line:get_nodes()
    return self.node_list
end

function Line:set_indent(indent)
    self.indent = indent
end

function Line:get_indent()
    return self.indent or 0
end

return Line