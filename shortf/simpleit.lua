local f = require'shortf'

local expression = {}
local expression_mt = {}

function expression.new(action)
	return setmetatable({
		action = action
	},expression_mt)
end

function expression.accepts(expression)
	return getmetatable(expression)==expression_mt
end

function expression_mt:__call(a)
	return self.action(a)
end

function expression_mt:__add(other)
	if
		expression.accepts(self)
		and expression.accepts(other)
	then
		return expression.new(function(a)
			return self(a)+other(a)
		end)
	end
	if 
		expression.accepts(self)
		and not expression.accepts(other)
	then
		return expression.new(function(a)
			return self(a)+other
		end)
	end
	if 
		not expression.accepts(self)
		and expression.accepts(other)
	then
		return expression.new(function(a)
			return self+other(a)
		end)
	end
	return expression.new(function(a)
		return self+other
	end)
end

function expression_mt:__sub(other)
	if
		expression.accepts(self)
		and expression.accepts(other)
	then
		return expression.new(function(a)
			return self(a)-other(a)
		end)
	end
	if 
		expression.accepts(self)
		and not expression.accepts(other)
	then
		return expression.new(function(a)
			return self(a)-other
		end)
	end
	if 
		not expression.accepts(self)
		and expression.accepts(other)
	then
		return expression.new(function(a)
			return self-other(a)
		end)
	end
	return expression.new(function(a)
		return self-other
	end)
end

function expression_mt:__mul(other)
	if
		expression.accepts(self)
		and expression.accepts(other)
	then
		return expression.new(function(a)
			return self(a)*other(a)
		end)
	end
	if 
		expression.accepts(self)
		and not expression.accepts(other)
	then
		return expression.new(function(a)
			return self(a)*other
		end)
	end
	if 
		not expression.accepts(self)
		and expression.accepts(other)
	then
		return expression.new(function(a)
			return self*other(a)
		end)
	end
	return expression.new(function(a)
		return self*other
	end)
end

function expression_mt:__div(other)
	if
		expression.accepts(self)
		and expression.accepts(other)
	then
		return expression.new(function(a)
			return self(a)/other(a)
		end)
	end
	if 
		expression.accepts(self)
		and not expression.accepts(other)
	then
		return expression.new(function(a)
			return self(a)/other
		end)
	end
	if 
		not expression.accepts(self)
		and expression.accepts(other)
	then
		return expression.new(function(a)
			return self/other(a)
		end)
	end
	return expression.new(function(a)
		return self/other
	end)
end

function expression_mt:__mod(other)
	if
		expression.accepts(self)
		and expression.accepts(other)
	then
		return expression.new(function(a)
			return self(a)%other(a)
		end)
	end
	if 
		expression.accepts(self)
		and not expression.accepts(other)
	then
		return expression.new(function(a)
			return self(a)%other
		end)
	end
	if 
		not expression.accepts(self)
		and expression.accepts(other)
	then
		return expression.new(function(a)
			return self%other(a)
		end)
	end
	return expression.new(function(a)
		return self%other
	end)
end

function expression_mt:__pow(other)
	if
		expression.accepts(self)
		and expression.accepts(other)
	then
		return expression.new(function(a)
			return self(a)^other(a)
		end)
	end
	if 
		expression.accepts(self)
		and not expression.accepts(other)
	then
		return expression.new(function(a)
			return self(a)^other
		end)
	end
	if 
		not expression.accepts(self)
		and expression.accepts(other)
	then
		return expression.new(function(a)
			return self^other(a)
		end)
	end
	return expression.new(function(a)
		return self^other
	end)
end

function expression_mt:__concat(other)
	if
		expression.accepts(self)
		and expression.accepts(other)
	then
		return expression.new(function(a)
			return self(a)..other(a)
		end)
	end
	if 
		expression.accepts(self)
		and not expression.accepts(other)
	then
		return expression.new(function(a)
			return self(a)..other
		end)
	end
	if 
		not expression.accepts(self)
		and expression.accepts(other)
	then
		return expression.new(function(a)
			return self..other(a)
		end)
	end
	return expression.new(function(a)
		return self..other
	end)
end


function expression_mt:__index(other)
	if
		expression.accepts(self)
		and expression.accepts(other)
	then
		return expression.new(function(a)
			return self(a)[other(a)]
		end)
	end
	if 
		expression.accepts(self)
		and not expression.accepts(other)
	then
		return expression.new(function(a)
			return self(a)[other]
		end)
	end
	if 
		not expression.accepts(self)
		and expression.accepts(other)
	then
		return expression.new(function(a)
			return self[other(a)]
		end)
	end
	return expression.new(function(a)
		return self[other]
	end)
end

return expression.new(f'(...)')

