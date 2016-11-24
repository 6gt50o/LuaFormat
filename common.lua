
NODE_TYPE = {
    LETTER          = {},
    BLANK           = {' '},
    OPERATOR        = {'+', '-', '*', '/', '^', ','},
    EQUAL           = {'=', '~'},
    BRACKET         = {'(', '{', '['},
    REVERSE_BRACKET = {')', '}', ']'},
    ENTER           = {'\n'},
    ANNOTATION      = {}
}

NODE_TYPE_KEY = {}
for k,v in pairs(NODE_TYPE) do
    NODE_TYPE_KEY[k] = tostring(k)
end

INDENT_NODE = {
    "function",
    "for",
    "repeat",
    "if",
}

UNINDENT_NODE = {
    "end",
    "until",
}

