local f = require'shortf'
local it = f.it

local get_price = f(it:getPrice())
local product = {getPrice=f'''1'}
assert(get_price(product)==1)
print'calling works'

local fun=f(it(3))
assert(fun(f'a''a')==3)
print'function call works'

local fun=f(it(it))
assert(fun(f'a''a')==f'a''a')
local fun=f(it(nil,it))
assert(fun(f'_,a''a')==f'_,a''a')
print'self calling works'

require'tests.expression.common_cases'(it,f)
require'tests.expression.composed_cases'(it,f)