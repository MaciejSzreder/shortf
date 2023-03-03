local f = require'shortf'

return function(it, build)
	build = build or f'(...)'
	
	local quadruple = build(2*it*2)
	assert(quadruple(3)==12)
	local quadruple = build(2*2*2*2*2*it*2*2*2*2*2)
	assert(quadruple(10)==10240)
	print'multilevel expression works'
	
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
		local fun=build(f(o)(l,f(o)(it,r)))
		assert(fun(arg)==both)
	end
	
end