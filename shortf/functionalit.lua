local expression = {}
debug.setmetatable(function()end,expression)

local it_functions = {}

local function register(fun)
	it_functions[fun]=true
	return fun
end

local function is_it_function(fun)
	return it_functions[fun]
end

local it =  register(function(...)return...end)

function expression:__add(other)
	if is_it_function(self) and is_it_function(other) then
		return register(function (arg)
			return self(arg) + other(arg)
		end)
	end
	if is_it_function(self) then
		return register(function (arg)
			return self(arg) + other
		end)
	end
	if is_it_function(other) then
		return register(function (arg)
			return self + other(arg)
		end)
	end
	return register(function (arg)
		return self + other
	end)
end

function expression:__sub(other)
	if is_it_function(self) and is_it_function(other) then
		return register(function (arg)
			return self(arg) - other(arg)
		end)
	end
	if is_it_function(self) then
		return register(function (arg)
			return self(arg) - other
		end)
	end
	if is_it_function(other) then
		return register(function (arg)
			return self - other(arg)
		end)
	end
	return register(function (arg)
		return self - other
	end)
end

function expression:__mul(other)
	if is_it_function(self) and is_it_function(other) then
		return register(function (arg)
			return self(arg) * other(arg)
		end)
	end
	if is_it_function(self) then
		return register(function (arg)
			return self(arg) * other
		end)
	end
	if is_it_function(other) then
		return register(function (arg)
			return self * other(arg)
		end)
	end
	return register(function (arg)
		return self * other
	end)
end

function expression:__div(other)
	if is_it_function(self) and is_it_function(other) then
		return register(function (arg)
			return self(arg) / other(arg)
		end)
	end
	if is_it_function(self) then
		return register(function (arg)
			return self(arg) / other
		end)
	end
	if is_it_function(other) then
		return register(function (arg)
			return self / other(arg)
		end)
	end
	return register(function (arg)
		return self / other
	end)
end

function expression:__mod(other)
	if is_it_function(self) and is_it_function(other) then
		return register(function (arg)
			return self(arg) % other(arg)
		end)
	end
	if is_it_function(self) then
		return register(function (arg)
			return self(arg) % other
		end)
	end
	if is_it_function(other) then
		return register(function (arg)
			return self % other(arg)
		end)
	end
	return register(function (arg)
		return self % other
	end)
end

function expression:__pow(other)
	if is_it_function(self) and is_it_function(other) then
		return register(function (arg)
			return self(arg) ^ other(arg)
		end)
	end
	if is_it_function(self) then
		return register(function (arg)
			return self(arg) ^ other
		end)
	end
	if is_it_function(other) then
		return register(function (arg)
			return self ^ other(arg)
		end)
	end
	return register(function (arg)
		return self ^ other
	end)
end

function expression:__concat(other)
	if is_it_function(self) and is_it_function(other) then
		return register(function (arg)
			return self(arg) .. other(arg)
		end)
	end
	if is_it_function(self) then
		return register(function (arg)
			return self(arg) .. other
		end)
	end
	if is_it_function(other) then
		return register(function (arg)
			return self .. other(arg)
		end)
	end
	return register(function (arg)
		return self .. other
	end)
end

return it