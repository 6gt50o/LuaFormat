
local const = require('const')
local NodeType = const.NodeType

------------------------------------------------------------
-- Node
------------------------------------------------------------
local Node = require('Node')
local _nodes = {}

local function create_node(char, ctype)
    local node = Node.new(char, ctype)
    table.insert(_nodes, node)
    return node
end

------------------------------------------------------------
-- Local Methods
------------------------------------------------------------
local function innered(tab, cell)
    for _, v in pairs(tab) do
        if v == cell then return true end
    end
    return false
end

local annotation_lock = false
local function foreach_char(node, c)
    -- get node type of char c
    local ctype = nil
    for k,v in ipairs(const.NodeTypeContent) do
        if innered(v, c) then 
            ctype = k 
            break
        end
    end
    if not ctype then ctype = NodeType.WORD end
    
    -- first node.
    if not node then
        node = create_node(c, ctype)
    -- annotation
    elseif c == ']' and tostring(node) == ']' then
        node:concat(c)
        annotation_lock = false
    elseif annotation_lock == true then
        node:concat(c)
    elseif c == '[' and tostring(node) == '[' then
        node:concat(c)
        node:set_type(NodeType.ANNOTATION)
        annotation_lock = true
    -- same type
    elseif ctype == node:get_type() then
        node:concat(c)
    -- different type
    else
        node = create_node(c, ctype)
    end

    return node
end

------------------------------------------------------------
-- Main
------------------------------------------------------------
function format(content)
    if type(content) ~= 'string' then return '' end

    local node, char
    repeat
        char = string.sub(content, 1, 1)
        content = string.sub(content, 2, #content)
        node = foreach_char(node, char)
    until #content == 0
    -- foreach_node()

    -- return foreach_line()
end

------------------------------------------------------------
-- Debug
------------------------------------------------------------
local content = io.open('./test.lua', "r"):read("*a")
-- io.open('./test.lua', "w"):write(format(content))
print( format( content ) )
