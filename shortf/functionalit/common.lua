local it_functions = {}
local function register(fun)
	it_functions[fun]=true
	return fun
end

local function is_it_function(fun)
	return it_functions[fun]
end

local fun_mt

local function function_creator(fun)
	return fun or function(...)return...end
end

local function callable_creator(fun)
	return setmetatable({
		action=fun or function(...)return...end
	},fun_mt)
end

local creator
local function initialize(install)
	local fun = function()end
	creator = function_creator
	fun_mt = {}
	if install and debug then
		if debug.getmetatable then
			fun_mt = debug.getmetatable(fun);
			if type(fun_mt)=='table' then
				return	-- creator returns function, fun_mt is old metatable
			end
		end
		fun_mt = {}
		if debug.setmetatable then
			debug.setmetatable(fun,fun_mt)
			return	-- creator returns function, fun_mt is new metatable
		end
	end
	-- there is no agree to install it or there is no option to install it
	creator = callable_creator
	return	-- it is callable, fun_mt is new metatable
end

local function create_it(install)
	if not creator then
		initialize(install)
	end
	return creator(),fun_mt
	-- local fun = function()end
	-- local it =  function(...)return...end
	-- local fun_mt = {}
	-- if install and debug then
	-- 	if debug.getmetatable then
	-- 		fun_mt = debug.getmetatable(fun);
	-- 		if type(fun_mt)=='table' then
	-- 			return it, fun_mt	-- it is function, fun_mt is old metatable
	-- 		end
	-- 	end
	-- 	fun_mt = {}
	-- 	if debug.setmetatable then
	-- 		debug.setmetatable(fun,fun_mt)
	-- 		return it,fun_mt	-- it is function, fun_mt is new metatable
	-- 	end
	-- end
	-- -- there is no agree to install it or there is no option to install it
	-- return setmetatable({action=it},fun_mt), fun_mt	-- it is callable, fun_mt is new metatable
end

return function (install)

	local it, fun_mt = create_it(install)
	register(it)

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

	function fun_mt:__call(...)
		return self.action(...)
	end

	return it
end