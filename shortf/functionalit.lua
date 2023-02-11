local expression = {}
debug.setmetatable(function()end,expression)

local it_functions = {}

local function register(fun)
	it_functions[fun]=true
	return fun
end

local it =  register(function(...)return...end)

function expression:__add(other)
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

function expression:__mul(other)
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
	if self == it then
		return register(function (arg)
			return arg * other
		end)
	end
	if it_functions[self] and other == it then
		return register(function (arg)
			return self(arg) * arg
		end)
	end
	if it_functions[self] and it_functions[other] then
		return register(function (arg)
			return self(arg) * other(arg)
		end)
	end
	if it_functions[self] then
		return register(function (arg)
			return self(arg) * other
		end)
	end
	if other == it then
		return register(function (arg)
			return self * arg
		end)
	end
	if it_functions[other] then
		return register(function (arg)
			return self * other(arg)
		end)
	end
	return register(function (arg)
		return self * other
	end)
end

function expression:__concat(other)
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