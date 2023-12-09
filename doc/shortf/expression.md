`shortf.expression`
========
Importing and content
---------------------
The module `shortf.expression` is callable table. To import it type:
```lua
local args = require'shortf.expression'
```
Calling this table works the same as function `args` and you can create object representing function arguments.
```lua
local point1,point2 = args(2)
local distance = ((point1.x-point2.x)^2+(point1.y-point2.y)^2)^0.5
print(distance({x=1,y=2},{x=4,y=6}))	--> prints 5
```
The `shortf.expression` contains template expression indicator `it` and function `args`.
```lua
local expression = require'shortf.expression'
local it = expression.it
local args = expression.args
```

object `it`
------------------
The `it` is used to create functions. Use it with operators to create function or call it to get result of calculations.
```lua
local circle_area = it*it*math.pi
print(circle_area(1))	--> prints 3.1415...
```

Due calling executes the calculations, using in expression give unexpected result
```lua
local getPrice = it.getPrice()*it.getDiscount()	--> error 
local stubProduct = {getPrice=f'''1',getDiscount=f'''1'}
print(getPrice(stubProduct))
```
The error is caused by executing `it.getPrice()`, where no argument was passed, so it tries get field `getPrice` from `nil`.

function `args`
---------------
The `args` can be used to create objects representing arguments. It takes the number of parameters for function.
```lua
local a,b,c = args(3)
local delta = b^2-4*a*c
print(delta(1,2,3))	--> prints -8
```

### `it` vs `args(1)`
`it` represents all arguments, but `args(1)` only the first.
```lua
print(it(1,2,3))	--> prints 1	2	3
print(args(1)(1,2,3))	--> prints 1
```