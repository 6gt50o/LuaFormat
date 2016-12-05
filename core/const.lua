
local const = {}

-- NodeType
const.NodeType = {
    WORD            = 1,
    BLANK           = 2,
    OPERATOR        = 3,
    EQUAL           = 4,
    BRACKET         = 5,
    REVERSE_BRACKET = 6,
    ENTER           = 7,
    ANNOTATION      = 8,
}

-- NodeTypeContent
local _nt = const.NodeType
const.NodeTypeContent = {
    [_nt.WORD]            = {},
    [_nt.BLANK]           = {' '},
    [_nt.OPERATOR]        = {'+', '-', '*', '/', '^', ','},
    [_nt.EQUAL]           = {'=', '~'},
    [_nt.BRACKET]         = {'(', '{', '['},
    [_nt.REVERSE_BRACKET] = {')', '}', ']'},
    [_nt.ENTER]           = {'\n'},
    [_nt.ANNOTATION]      = {}
}

-- IndentKeyword
const.IndentKeyword = {
    "function",
    "for",
    "repeat",
    "if",
}

-- UnindentKeyword
const.UnindentKeyword = {
    "end",
    "until",
}

return const