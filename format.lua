
local utils = require('utils')
require('common')

------------------------------------------------------------
-- Line
------------------------------------------------------------
local Line = require('Line')
local _lines = {}

function new_line(node)
    local line = Line.new()
    line:push(node)
    table.insert(_lines, line)
    return line
end

function foreach_line()
    local indent = 0
    for _, line in ipairs(_lines) do
        line:set_indent(indent)
        for _, node in ipairs(line:get_nodes()) do
            if utils.innered(INDENT_NODE, node) then 
                indent = indent + 1 
            end
            if utils.innered(UNINDENT_NODE, node) then 
                indent = indent - 1 
                line:set_indent(indent)
            end
        end
    end

    local result = ''
    for _, line in ipairs(_lines) do
        local indent_blank = ''
        for i = 1, line:get_indent() do
            indent_blank = indent_blank .. '    '
        end
        result = result .. indent_blank .. tostring(line)
    end
    return result
end

------------------------------------------------------------
-- Node
------------------------------------------------------------
local Node = require('Node')
local _nodes = {}

function new_node(c, ctype)
    local node = Node.new()
    node:set_type(ctype)
    node:push(c)
    table.insert(_nodes, node)
    return node
end

function foreach_node()
    line = new_line()
    for _, node in ipairs(_nodes) do
        line:push(node)
        if node:get_type() == "ENTER" then
            line = new_line()
        end
    end
end

------------------------------------------------------------
-- Main
------------------------------------------------------------
local annotation_lock = false
function foreach_char(node, c)
    function _get_char_type()
        for k,v in pairs(NODE_TYPE) do
            if utils.innered(v, c) then return k end
        end
        return NODE_TYPE_KEY.LETTER
    end
    local ctype = _get_char_type()

    if not node then
        node = new_node(c, ctype)
    elseif c == ']' and tostring(node) == ']' then
        node:push(c)
        annotation_lock = false
    elseif annotation_lock == true then
        node:push(c)
    elseif c == '[' and tostring(node) == '[' then
        node:set_type(NODE_TYPE_KEY.ANNOTATION)
        annotation_lock = true
        node:push(c)
    elseif ctype == node:get_type() then
        node:push(c)
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
        node = foreach_char(node, char)
    until #content == 0
    foreach_node()

    return foreach_line()
end

------------------------------------------------------------
-- EOF
------------------------------------------------------------

local content = [[
for i=1,10 do
for j=1,10 do
        print(i,j)
    end
end

local test = function()
        print('test')
        end
]]
------------------------------------------------------------
local content = io.open('./test.lua', "r"):read("*a")

print(format(content))
