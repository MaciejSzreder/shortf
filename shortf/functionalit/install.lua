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
	if old_add and (type(self)=='function' or type(other)=='function') then
		return old_add(self,other)
	end
	return register(function (arg)
		return self + other
	end)
end

local old_sub = fun_mt.__sub
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
	if old_sub and (type(self)=='function' or type(other)=='function') then
		return old_sub(self,other)
	end
	return register(function (arg)
		return self - other
	end)
end

local old_mul = fun_mt.__mul
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
	if old_mul and (type(self)=='function' or type(other)=='function') then
		return old_mul(self,other)
	end
	return register(function (arg)
		return self * other
	end)
end

local old_div = fun_mt.__div
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
	if old_div and (type(self)=='function' or type(other)=='function') then
		return old_div(self,other)
	end
	return register(function (arg)
		return self / other
	end)
end

local old_mod = fun_mt.__mod
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
	if old_mod and (type(self)=='function' or type(other)=='function') then
		return old_mod(self,other)
	end
	return register(function (arg)
		return self % other
	end)
end

local old_pow = fun_mt.__pow
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
	if old_pow and (type(self)=='function' or type(other)=='function') then
		return old_pow(self,other)
	end
	return register(function (arg)
		return self ^ other
	end)
end

local old_concat = fun_mt.__concat
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
	if old_concat and (type(self)=='function' or type(other)=='function') then
		return old_concat(self,other)
	end
	return register(function (arg)
		return self .. other
	end)
end

local old_index = fun_mt.__index
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
	if old_index and type(self)=='function' then
		return old_index(self,other)
	end
	return register(function (arg)
		return self[other]
	end)
end

return it