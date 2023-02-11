local it_mt = {}
local it = setmetatable({},it_mt)

function it_mt:__mul(other)
	if self==it then
		return function(arg)
			return arg*other
		end
	end
	return function(arg)
		return self*arg
	end
end

function it_mt:__concat(other)
	if self==it then
		return function(arg)
			return arg..other
		end
	end
	return function(arg)
		return self..arg
	end
end

return it

