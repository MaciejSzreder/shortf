`shortf`
========
Importing and content
---------------------
The module `shortf` is callable table. To import it, type:
```lua
local f = require'shortf'
```
Calling this table works the same as function `f` and you can eg. create functions with it.
```lua
local area = f'r''r^2*math.pi'
```
The `shortf` contains function `f`, template expression indicator `it`, and function `args`.
```lua
local shortf = require'shortf'
local f = shortf.f
local it = shortf.it
local args = shortf.args
```

function `f`
------------------
The `f` is used to create functions or get functions performing operators.

### `f` operators
To obtain function performing operators on theirs arguments, pass its string representation.
```lua
local add = f'+'	--> add is function
local phi = f'/'(f'+'(f'^'(5,0.5),1),2) --> phi = ((5^0.5)+1)/2
```
Supported operators:
`f` operator | `f` closure
-------------|------------
`f'+'`       | `f'a,b''a+b'`
`f'-'`       | `f'a,b''a-b'`
`f'*'`       | `f'a,b''a*b'`
`f'/'`       | `f'a,b''a/b'`
`f'%'`       | `f'a,b''a%b'`
`f'^'`       | `f'a,b''a^b'`
`f'=='`      | `f'a,b''a==b'`
`f'~='`      | `f'a,b''a~=b'`
`f'>='`      | `f'a,b''a>=b'`
`f'<='`      | `f'a,b''a<=b'`
`f'<'`       | `f'a,b''a<b'`
`f'>'`       | `f'a,b''a>b'`
`f'and'`     | `f'a,b''a and b'`
`f'or'`      | `f'a,b''a or b'`
`f'not'`     | `f'a,b''not b'`
`f'..'`      | `f'a,b''a..b'`
`f'#'`       | `f'a,b''#b'`
`f'[]'`      | `f'a,b''a[b]'`
`f'(...)'`   | `f'...''...'`
`f'{...}'`   | `f'...''{...}'`
`f'()'`      | `f'f,...''f(...)'`

### `f` functions
You can use `f` to create simple functions. The `f` takes a parameter list and a expression list. The parameter list is string containing Lua parameter list ([parlist](https://www.lua.org/manual/5.1/manual.html#8)). After applying parameter list, you need to apply body of the function. Body is string containing a Lua expression list ([explist](https://www.lua.org/manual/5.1/manual.html#8)).

#### Examples
If function takes no argument, pass empty string as parameter list:
```lua
local getVersion = f'''_VERSION'
```
To take all parameters use ellipsis:
```lua
local quantity_print = f'...''print(select("#",...),...)'
```

#### upvalues and environment
Funstions created with `f` are not aware local variables of environment in which it was created, but have access to globals:
```lua
local circle_area = f'r''r*r*math.pi'
print(circle_area(10)) -- OK
```
```lua
local pi = math.pi
local circle_area = f'r''r*r*pi'
print(circle_area(10)) -- error
```

#### recursion
There is `self` variable in `f` body containing curently created function. It can be use to preform recursion.
```lua
local gcd = f'a,b'[[
	a==0
	and b
	or self(b%a,a)
]]
print(gcd(12,18)) -- prints 6
```
### `f` other functions
For some invalid parameter list is assigned function.

`f`-function | `f`-closure
-------------|------------
`f'(...)'`   |`f'...''...'`
`f'true'`    |`f'''true'`
`f'false,'`  |`f'''false'`
`f'nil'`     |`f'''nil'`
`f'if'`      |`f'condition, onTrue, onFalse''(condition and {onTrue} or {onFalse})[1]'`

### expresion template with `f`
If arguments for `f` are strings, linters do not show any error and parser show syntax error on the run time. Use `f.it` or `f.args` towrite expression and allow linters and paresrs to analyse the syntax. To extract function from expression pass it to `f`.

#### expresion template with `f.it`
`f.it` is itself expression template, as a function it passes through all parameters.
```lua
local pass = f(it)
print(pass(1,2,3))	--> prints 1 2 3
```
Using operators with `f.it` creates next expresion template, but it losts all parameters but first.
```lua
local polynomial = f(2*it^3+it*it+1)
print(polynomial(3))	--> prints 64
```

#### expresion template with `f.args`
If you need more parameters than just one for expression template use `f.args` with number of parameters, and assing the results to variables. Each wariable captures single parameter.
```lua
local a,b = args(2)
local first = f(a)
local second = f(b)
print(first(1,2))	--> prints 1
print(second(1,2))	--> prints 2
```
Mixing result of `f.args` and operators gine next expression template.
```lua
local a,b,c = args(3)
local delta = f(a^2-4*a*c)
print(delta(1,2,3))	--> prints -23
```
### supported expressions
expression    | support
--------------|--------
`a[b]`        | only `a`
`a(b)`        | only `a`
`a[b]=c`      | no
`a+b`         | yes
`a-b`         | yes
`-a`          | no
`a*b`         | yes
`a/b`         | yes
`a%b`         | yes
`a^b`         | yes
`a..b`        | yes
`a<b`         | no
`a<=b`        | no
`a==b`        | no
`a and b`     | no
`a or b`      | no
`not b`       | no
`#b`          | no
`tostring(a)` | no