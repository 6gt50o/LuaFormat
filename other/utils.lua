local utils = {}

function utils.innered(list, cell)
    for _, v in pairs(list) do
        if v == cell then return true end
    end
    return false
end

return utils