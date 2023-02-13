Short f
======
Short f is Lua liblary providing short syntax for closure creation. The liblary is tested in Lua 5.1.

Syntax
------
To use the liblary you have to `require` it.
```lua
local f = require'shortf'
```

The Lua standard closure creation syntax is long.
```lua
local closure = function(a,b)
	return a+b
end
```
This liblary allow to shorten it.
```lua
local closure = f'a,b''a+b'
```
Or even shorter.
```lua
local closure = f'+'
```
### `f`-closure syntax
The `f` for function creating, takes 2 curring arguments. The first is string contains arguments identifiers separated with comma, the last argument can be elipsis `...`. The second is string representing expression which value will be returned.

Zero argument function returning current Lua version
```lua
local getVersion = f'''__VERSION'
```

Function calculating price for product.
```lua
local getPrice = f'product''product.price*product.promotion'
```

Function duplicating first argument.
```lua
local double = f'...''...,...'
```

Function counting its arguments.
```lua
local len = f'...''select("#",...)'
```
### `f`-operator closures
If you often require to create closure for single operator to use, you can use closures created for operators. To get them, pass its string representation to `f`.  
Supported operators: `+`, `-`, `*`, `/`, `%`, `^`, `==`, `~=`, `>=`, `<=`, `<`, `>`, `and`, `or`, `not`, `..`, `#`, `[]` _index access_, `()` _function call_, `{...}` _table creation_. As long they are not valid identifiers, as long they do not colide with closure creation `f` syntax.

`f`-operator | `f`-closure
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

Sort in reversed order.
```lua
table.sort(prices,f'>')
```

### other build in `f`-function
There also other invalid identifiers whitch was used to create closures. Some of them was selected to represents some functions

`f`-function | `f`-closure
-------------|------------
`f'(...)'`   |`f'...''...'`
`f'true'`    |`f'''true'`
`f'false,'`  |`f'''false'`
`f'nil'`     |`f'''nil'`
`f'if'`      |`f'condition, onTrue, onFalse''(condition and {onTrue} or {onFalse})[1]'`

### recursion in `f`-closures
Performing recursion by calling function name do not work, because `f` do not have access to local variables. To solve this problem `f` provides local variable `self` containing current function.

Recursive calculating Fibonacci numbers.
```lua
local fib = f'n'[[
	n<2
	and n
	or self(n-1)+self(n-1)
]]
```

todo
----
⏱️ expression templates
⬜ currling  
⬜ partial apply
⬜ partial apply by name  
⬜ memoization  
⬜ upvalues   
⬜ multiline functions  
⬜ local variable creating
⬜ errors maping 
⬜ does `f'-'` should represent both binary and unary operator `-`?  
⬜ does expression templates should serve `__newindex`?
⬜ what should return casting to string?