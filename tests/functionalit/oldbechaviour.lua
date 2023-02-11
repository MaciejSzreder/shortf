local fun_mt = {'old metatable'}
debug.setmetatable(function()end,fun_mt)

function fun_mt:__add(other)
	return 'old bechaviour'
end

local it = require'shortf.functionalit'


local meta_data = debug.getmetatable(function()end)[1]
assert(meta_data == 'old metatable')
local metatable = debug.getmetatable(function()end)
assert(metatable == fun_mt)
print'metatable not damaged'

local sum = function()end + function()end
assert(sum=='old bechaviour')
print'old behaviour not changed'