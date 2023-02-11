local it = require'shortf.simpleit'
local f = require'shortf'

local double = it*2
assert(double(3)==6)
local triple = 3*it
assert(triple(4)==12)
print'multiplication works'

local prefix = 'prefix_'..it
assert(prefix'a'=='prefix_a')
local postfix = it..'_postfix'
assert(postfix'b'=='b_postfix')
print'concatenation works'

local quadruple = 2*it*2
assert(quadruple(3)==12)
local quadruple = 2*2*2*2*2*it*2*2*2*2*2
assert(quadruple(10)==10240)
print'multilevel expression works'

local power = it*it
assert(power(3)==9)
print'multiple it using works'

for _,case in pairs{
	{o='+',v={2,3,4},r={5,9,7}},
	{o='-',v={2,3,5},r={-1,4,-2}},
	{o='*',v={2,3,4},r={6,24,12}},
	{o='/',v={2,3,4},r={2/3,8/3,3/4}},
	{o='%',v={10,6,3},r={4,1,0}},
	{o='^',v={2,3,4},r={8,2^81,81}},
	{o='..',v={'2','3','4'},r={'23','234','34'}},
	{o='==',v={2,2,4},r={true,false,false}},
	-- {o='<',v={3,3,4},r={false,24,12}},
	-- {o='[]',v={2,3,4},r={6,24,12}},
} do
	local o = case.o
	local l,arg,r = unpack(case.v)
	local pre,both,post = unpack(case.r)
	local fun=f(o)(l,it)
	assert(fun(arg)==pre)
	local fun=f(o)(it,r)
	assert(fun(arg)==post)
	local fun=f(o)(l,f(o)(it,r))
	assert(fun(arg)==both)
end