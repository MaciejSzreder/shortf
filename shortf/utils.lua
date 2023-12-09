local utils = {}
local setmetatable = setmetatable

if setmetatable then
	function utils.make_module(module,metatable)
		return setmetatable(module,metatable)
	end
else
	function utils.make_module(module,metatable)
		return module
	end
end

function utils.getmetatable(object)
	local metatable
	if type(object)=='table' then
		metatable = getmetatable and getmetatable(object)
		if not metatable then
			metatable = {}
			setmetatable(object,metatable)
		end
		return metatable
	end
		
	return debug.getmetatable or debug.setmetatable
end

return utils