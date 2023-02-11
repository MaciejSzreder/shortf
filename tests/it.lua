local it = require'shortf.simpleit'

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