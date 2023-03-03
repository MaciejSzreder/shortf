local f = require'shortf'

return function(it, build)
	build = build or f'(...)'

	local double = build(it*2)
	assert(double(3)==6)
	local triple = build(3*it)
	assert(triple(4)==12)
	print'multiplication works'

	local prefix = build('prefix_'..it)
	assert(prefix'a'=='prefix_a')
	local postfix = build(it..'_postfix')
	assert(postfix'b'=='b_postfix')
	print'concatenation works'

	local quadratic = build(2*it*it+it)
	assert(quadratic(3)==21)
	print'complex expression works'

	local power = build(it*it)
	assert(power(3)==9)
	print'multiple it using works'

	local neg = build(-it)
	assert(neg(3)==-3)
	print'sign change works'

	for _,case in pairs{
		{o='+',v={2,3,4},r={5,9,7},it=6},
		{o='-',v={2,3,5},r={-1,4,-2},it=0},
		{o='*',v={2,3,4},r={6,24,12},it=9},
		{o='/',v={2,3,4},r={2/3,8/3,3/4},it=1},
		{o='%',v={11,10,6},r={1,3,4},it=0},
		{o='^',v={2,3,4},r={8,2^81,81},it=27},
		{o='..',v={'2','3','4'},r={'23','234','34'},it='33'},
	} do
		local o = case.o
		local l,arg,r = unpack(case.v)
		local pre,both,post = unpack(case.r)
		local fun=build(f(o)(l,it))
		assert(fun(arg)==pre)
		local fun=build(f(o)(it,r))
		assert(fun(arg)==post)
		local fun=build(f(o)(it,it))
		assert(fun(arg)==case.it)
	end
	print'operators work'

	local fun=build(it[1])
	assert(fun({3})==3)
	print'index access works'

	local fun=build(it[it])
	local s={}
	s[s]=3
	assert(fun(s)==3)
	print'self indexing works'

end