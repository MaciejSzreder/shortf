local it_mt = {}
local it = setmetatable({},it_mt)

local it_functions = {}

local function register(fun)
	it_functions[fun]=true
	return fun
end

function it_mt:__add(other)
	if self == it and other == it then
		return register(function (arg)
			return arg + arg
		end)
	end
	if self == it and it_functions[other] then
		return register(function (arg)
			return arg + other(arg)
		end)
	end
	if it_functions[self] and other == it then
		return register(function (arg)
			return self(arg) + arg
		end)
	end
	if self == it then
		return register(function (arg)
			return arg + other
		end)
	end
	if other == it then
		return register(function (arg)
			return self + arg
		end)
	end
	return register(function (arg)
		return self * other
	end)
end

function it_mt:__mul(other)
	if self == it and other == it then
		return register(function (arg)
			return arg * arg
		end)
	end
	if self == it and it_functions[other] then
		return register(function (arg)
			return arg * other(arg)
		end)
	end
	if it_functions[self] and other == it then
		return register(function (arg)
			return self(arg) * arg
		end)
	end
	if self == it then
		return register(function (arg)
			return arg * other
		end)
	end
	if other == it then
		return register(function (arg)
			return self * arg
		end)
	end
	return register(function (arg)
		return self * other
	end)
end

function it_mt:__concat(other)
	if self == it and other == it then
		return register(function (arg)
			return arg .. arg
		end)
	end
	if self == it then
		return register(function (arg)
			return arg .. other
		end)
	end
	if other == it then
		return register(function (arg)
			return self .. arg
		end)
	end
	return register(function (arg)
		return self .. other
	end)
end

return it