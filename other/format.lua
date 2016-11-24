
local utils = require('utils')
require('common')

------------------------------------------------------------
-- Line
------------------------------------------------------------
local Line = require('Line')
local _lines = {}

function new_line(node)
    local line = Line.new()
    concat_line(line, node)
    table.insert(_lines, line)
    return line
end

function concat_line(line, node)
    line:concat(node)
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
        --[[Floyda Debug]] print("Floyda ==== format ==== line:get_indent()", line:get_indent(), line)
    end
end

------------------------------------------------------------
-- Node
------------------------------------------------------------
local Node = require('Node')
local _nodes = {}

function concat_node(node, c)
    node:concat(c)
end

function new_node(c, ctype)
    local node = Node.new()
    node:set_type(ctype)
    concat_node(node, c)
    table.insert(_nodes, node)
    return node
end

function foreach_node()
    line = new_line()
    for _, node in ipairs(_nodes) do
        concat_line(line, node)
        if node:get_type() == "ENTER" then
            line = new_line()
        end
    end
end

------------------------------------------------------------
-- Main
------------------------------------------------------------
function foreach_char(node, c)
    -- get type of variable c
    function _get_char_type()
        for k,v in pairs(CHAR_TYPE) do
            if utils.innered(v, c) then return k end
        end
        return 'LETTER'
    end
    local ctype = _get_char_type()

    if not node then
        node = new_node(c, ctype)
    elseif ctype == node:get_type() then
        concat_node(node, c)
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
    foreach_line()
    return ''
end

------------------------------------------------------------
-- EOF
------------------------------------------------------------

local content = [[
for i=1,10 do
    for j=1,10 do
        print(i,j)
    end
end]]
-- content = "hello world"

format(content)
