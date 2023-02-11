local it_mt = {}
local it = setmetatable({},it_mt)

local expression = {}
local expression_mt = {}

function expression.new(action)
	return setmetatable({
		action = action
	},expression_mt)
end

function expression.accepts(expression)
	return getmetatable(expression)==expression_mt or getmetatable(expression)==it_mt
end

function expression_mt:__call(arg)
	return self.action(arg)
end

function expression_mt:__mul(other)
	if expression.accepts(self) then
		return expression.new(function(arg)
			return self(arg)*other
		end)
	end
	return expression.new(function(arg)
		return self*other(arg)
	end)
end

function it_mt:__mul(other)
	if expression.accepts(self) then
		return expression.new(function(arg)
			return arg*other
		end)
	end
	return expression.new(function(arg)
		return self*arg
	end)
end

function it_mt:__concat(other)
	if expression.accepts(self) then
		return expression.new(function(arg)
			return arg..other
		end)
	end
	return expression.new(function(arg)
		return self..arg
	end)
end

return it

