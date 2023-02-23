Short f
======
Short f is Lua library providing short syntax for function creation. The library is tested in Lua 5.1.

Motivation
----------
In pure lua creating function is verbose:
```lua
local closure = function(a,b)
	return a+b
end
```
This construction is awkward to use as argument. Eg. when you want to sort in decreasing order:
```lua
local numbers = {3,1,4,1,5}
table.sort(numbers,function(first,second) return first>second end)
print(unpack(numbers)) --> prints 5 4 3 1 1
```
This library allows to make it more concrete.

Importing
---------
The main module is in `shortf`.
```lua
local f = require'shortf'
```

Content
-------
### functions for operators
This library have short syntax of function for operator: just pass operator as string to `f`:
```lua
local numbers = {3,1,4,1,5}
table.sort(numbers,f'>')
print(unpack(numbers)) --> prints 5 4 3 1 1
```

### other build in `f`-function
For some invalid parameters list are prepared functions.
```lua
local pass = f'(...)'
print(pass(1,2))	--> prints 1 2
```

### function creation with `f`
You can create simple functions with `f` by passing parameter list and body expression.
```lua
local length = f'n''math.floor(math.log(n)/math.log(10))+1' -- count digits in decimal base
print(length(10))	--> prints 2
```

### expression templates with `f`
You can use `f.it` or `f.args` to keep highlighting.
```lua
local it = f.it
```
You can pass expression with `it` to `f` to create function.
```lua
local gold = f((it+(it^2+4)^0.5)/2)
print(gold(0))	--> prints 1
```

### expression templates without `f`
You can use `it` and `args` from `shortf.expression` to keep highlighting and do not use `f` to build function.
```lua
local args = require'shortf.expression'
local it = args.it
```
You can create callable with `it`.
```lua
local silver = (it-(it^2+4)^0.5)/2
print(silver(0))	--> prints -1
```

todo
----
⏱️ expression templates  
⬜ currying  
⬜ partial apply  
⬜ partial apply by name  
⬜ memoization  
⬜ upvalues  
⬜ multiline functions  
⬜ local variable creating  
⬜ errors mapping  
⬜ does `f'-'` should represent both binary and unary operator `-`?  
⬜ does expression templates should serve `__newindex`?  
⬜ what should return casting to string?  
⬜ sentinel for `args`  
⬜ recursive `self` for expression templates  
⬜ `f` could be exploited  
⬜ make `f` to not require `loadstring`  