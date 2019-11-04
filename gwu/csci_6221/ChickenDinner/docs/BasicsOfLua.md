# Basics Lua
## Fundamental knowledge

### define a variable 
``` lua
local example =1
```

### define a function 
<b>!!! All functions you want to use must define before where you write !!!</b>

``` lua
local function example_function()

end

local function add_function(num1, num2)
    local answer= num1+ num2
    return answer
end

local var = add(1,2)
```

### if 
``` lua
local example = 1 

if example == 10 then
    
elseif example > 0 then
    
else
    
end 
```

### loops 
``` lua
for i = 0, 10, 1 do
    print(i)
end

while example >= 3 do
    print("it's still 3 or more")
end
```



## reference
don't starve unofficial api http://dontstarveapi.com/lua/fundamental-blocks/
lua official document http://www.lua.org/manual/5.1/

