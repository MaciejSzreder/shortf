local fun_mt = {'old metatable'}
debug.setmetatable(function()end,fun_mt)

function fun_mt:__add(other)
	return '+'
end
function fun_mt:__sub(other)
	return '-'
end
function fun_mt:__mul(other)
	return '*'
end
function fun_mt:__div(other)
	return '/'
end
function fun_mt:__mod(other)
	return '%'
end
function fun_mt:__pow(other)
	return '^'
end
function fun_mt:__concat(other)
	return '..'
end
function fun_mt:__index(other)
	return '[]'
end

local it = require'shortf.expression.functional'.it
local f= require'shortf'

local fun = function()end

local meta_data = debug.getmetatable(fun)[1]
assert(meta_data == 'old metatable')
local metatable = debug.getmetatable(fun)
assert(metatable == fun_mt)
print'metatable not damaged'

for o in ('+,-,*,/,%,^,..'):gmatch'([^,]+)' do
	assert(f(o)(fun,fun)==o)
	assert(f(o)(1,fun)==o)
	assert(f(o)(fun,2)==o)
end
assert(fun[fun]=='[]')
assert(fun[1]=='[]')
print'old behaviour not changed'