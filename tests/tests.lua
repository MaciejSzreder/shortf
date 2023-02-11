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


local f_fib = f'n''n<2 and n or self(n-1)+self(n-2)'
assert(type(f_fib)=='function')

local function fib(n)
	local f1,f2 = 0,1
	for i=1,n do
		f1,f2 = f2,f1+f2
	end
	return f1
end

for i=1,10 do
	assert(fib(i)==f_fib(i))
end
print'recurencive f-function works'