local it_mt = {}
local it = setmetatable({},it_mt)

function it_mt:__mul(other)
	if self == it and other == it then
		return function (arg)
			return arg * arg
		end
	end
	if self == it then
		return function (arg)
			return arg * other
		end
	end
	if other == it then
		return function (arg)
			return self * arg
		end
	end
	return function (arg)
		return self * other
	end
end

return it