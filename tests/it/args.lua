local it, args = require'shortf.it.functional'()
local x1,y1,x2,y2 = args(4)

local distance = ((x1-x2)^2+(y1-y2)^2)^0.5
assert(distance(0,0, 3,4) == 5)