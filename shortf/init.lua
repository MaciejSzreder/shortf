local concat = table.concat

local memorized = {}
local operators = {}

local function f(args)
	local o = operators[args]
	if o then
		return o
	end
	memorized[args] = memorized[args] or {}
	return function(body)
		local fun = memorized[args][body] or loadstring(concat{
			[[
				local self
				self = function(]],args,[[)
					local f, it = require'shortf'
					return ]],body,[[
				end
				return self
			]]
		})()
		memorized[args][body] = fun
		return fun
	end
end

operators['+']=f'a,b''a+b'
operators['-']=f'a,b''a-b'
operators['*']=f'a,b''a*b'
operators['/']=f'a,b''a/b'
operators['%']=f'a,b''a%b'
operators['^']=f'a,b''a^b'
operators['==']=f'a,b''a==b'
operators['~=']=f'a,b''a~=b'
operators['>=']=f'a,b''a>=b'
operators['<=']=f'a,b''a<=b'
operators['<']=f'a,b''a<b'
operators['>']=f'a,b''a>b'
operators['and']=f'a,b''a and b'
operators['or']=f'a,b''a or b'
operators['not']=f'a,b''not b'
operators['..']=f'a,b''a..b'
operators['#']=f'a,b''#b'
operators['[]']=f'a,b''a[b]'
operators['(...)']=f'...''...'
operators['{...}']=f'...''{...}'
operators['()']=f'f,...''f(...)'
operators['true']=f'''true'
operators['false']=f'''false'
operators['nil']=f'''nil'
operators['if']=f'c,a,b''(c and {a} or {b})[1]'

return f