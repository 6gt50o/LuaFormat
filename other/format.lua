
require('common')
local Node = require('Node')
local Line = require('Line')

local _nodes = {}
local _lines = {}

function new_node(c, ctype)
    local node = Node.new()
    node:set_type(ctype)
    node:concat(c)
    table.insert(_nodes, node)
    return node
end

function new_line(node)
    local line = Line.new()
    line:concat(node)
    table.insert(_lines, line)
    return line
end

function deal_node()
    for i, v in ipairs(_nodes) do
        print(i,v)
    end
end

function deal_char(node, c)
    function innered(list, cell)
        for _, v in pairs(list) do
            if v == cell then return true end
        end
        return false
    end


    function get_char_type()
        for k,v in pairs(CHAR_TYPE) do
            if innered(v, c) then return k end
        end
        return 'LETTER'
    end
    local ctype = get_char_type()

    if not node then
        node = new_node(c, ctype)
    elseif ctype == node:get_type() then
        node:concat(c)
    else
        node = new_node(c, ctype)
    end
    return node
end

function format(content)
    if type(content) ~= 'string' then return end
    local node, char
    repeat
        char = string.sub(content, 1, 1)
        content = string.sub(content, 2, #content)
        node = deal_char(node, char)
        -- print(node:get_type(), node.content)
    until #content == 0

    deal_node()

    return ''
end

local content = [[
for i=1,10 do
    print(i)
end
]]
-- content = "hello world"

format(content)
