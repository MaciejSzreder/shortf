local it = require'shortf.expression.semifunctional'.it

assert(type(it*2)=='function')
print'it creates functions'

require'tests.expression.common_cases'(it)