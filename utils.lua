
local regular = require "regular"
local utils = {}

function utils.find_all_str(str, pattern)
    local r = {}
    local count = 0
    repeat
        local begin_index, end_index = string.find(str, pattern)
        if begin_index then
            str = string.sub(str, end_index + 1, #str)
            local cell = {count + begin_index, count + end_index}
            count = count + end_index
            table.insert(r, cell)
        else
            break
        end
    until false
    return r
end

function utils.test_find_all_str()
    local str = "a==1==2"
    local tab = utils.find_all_str(str, "==")
    for i,v in ipairs(tab) do
        print(v[1], v[2])
    end
end

-- function utils.split_char(str, char, filter)
function utils.split_char(str, char)
    local char_pattern = regular.MULTIPLE_BLANK .. char .. regular.MULTIPLE_BLANK
    local result_pattern = ' ' .. char .. ' '

    print(string.find(str, char_pattern))
    
    -- local index
    -- str, index = string.gsub(str, char_pattern, result_pattern)
    -- print("Floyda ======= index", index)
    return str
end

return utils
