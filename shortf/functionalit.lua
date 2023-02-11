local fun = function()end
local fun_mt = debug.getmetatable(fun) or {}
debug.setmetatable(fun,fun_mt)

local it_functions = {}

local function register(fun)
	it_functions[fun]=true
	return fun
end

local function is_it_function(fun)
	return it_functions[fun]
end

local it =  register(function(...)return...end)

local old_add = fun_mt.__add
function fun_mt:__add(other)
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
	if old_add and type(self)=='function' or type(other)=='function' then
		return old_add(self,other)
	end
	return register(function (arg)
		return self + other
	end)
end

function fun_mt:__sub(other)
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

function fun_mt:__mul(other)
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

function fun_mt:__div(other)
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

function fun_mt:__mod(other)
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

function fun_mt:__pow(other)
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

function fun_mt:__concat(other)
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

function fun_mt:__index(other)
	if is_it_function(self) and is_it_function(other) then
		return register(function (arg)
			return self(arg)[other(arg)]
		end)
	end
	if is_it_function(self) then
		return register(function (arg)
			return self(arg)[other]
		end)
	end
	if is_it_function(other) then
		return register(function (arg)
			return self[other(arg)]
		end)
	end
	return register(function (arg)
		return self[other]
	end)
end

return it