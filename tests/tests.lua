local f = require'shortf'

for operator in ('+,-,*,/,%,^,==,~=,>=,<=,<,>,and,or,not,..,#,[],(),(...),{...},true,false,nil,if'):gmatch'([^,%s]+)' do
	assert(type(f(operator))=='function')
	print(operator..' is callable')
end


local function closure_function(x,y)
	return (x^2+y^2)^0.5
end

local f_function = f'x,y''(x^2+y^2)^0.5'

assert(type(f_function)=='function')
print'f creates callable'

for i=1,100 do
	local x,y = math.random(),math.random()
	assert(closure_function(x,y)==f_function(x,y))
end
print'f creates identical callable to closure function'


local cashed_f_function = f'x,y''(x^2+y^2)^0.5'
assert(f_function==cashed_f_function)
print'f cashes callables'