local it = require'shortf.expression.callable'.it
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
	{o='+',v={2,3,4},r={5,9,7},it=6},
	{o='-',v={2,3,5},r={-1,4,-2},it=0},
	{o='*',v={2,3,4},r={6,24,12},it=9},
	{o='/',v={2,3,4},r={2/3,8/3,3/4},it=1},
	{o='%',v={11,10,6},r={1,3,4},it=0},
	{o='^',v={2,3,4},r={8,2^81,81},it=27},
	{o='..',v={'2','3','4'},r={'23','234','34'},it='33'},
	-- {o='==',v={2,2,4},r={true,false,false}},
	-- {o='<',v={3,3,4},r={false,24,12}},
	-- {o='[]',v={{2,3},{2},1},r={nil,3,2},it=nil},
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
	local fun=f(o)(it,it)
	assert(fun(arg)==case.it)
end

local fun=it[1]
assert(fun({3})==3)

local fun=it[it]
local s={}
s[s]=3
assert(fun(s)==3)