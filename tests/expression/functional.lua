local it = require'shortf.expression.functional'.it

assert(type(it)=='function')
assert(type(it*2)=='function')
print'it creates functions'

require'tests.expression.common_cases'(it)
require'tests.expression.composed_cases'(it)