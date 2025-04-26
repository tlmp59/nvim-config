<h3 aligin="center"> Following Advent Neovim </h3>

### Chapter 1: Lua - The foundation
- Write something about lua its origin, why it was chosen to be neovim config language
- Mechanism over policy? - Tjdevries
- Including some basic things one needs to know about lua programming language to start with Neovim

Variables, Functions, Loops, Data structures, Modules, etc.

<p align="center">Loops</p>
```lua
local rand_list = { "apple", "orange", "banana" }

for i = 1, #rand_list do
  print(i, rand_list[i])
end

--[[ 
    return:
     1 apple
     2 orange
     3 banana
--]]


for i, v in ipairs(rand_list) do -- think ipairs as a pair of index and value
  print(i, v)
end
-- return same as above

local rand_map = { apple = 10, orange=5, banana=3 }
for k, v in pairs(rand_map) do -- think pairs as a pair of key and value
  print(k, v)
end
```
<p align="center">Function</p>
```lua
-- multiple return
local return_four_values = functions()
  return 1, 2, 3, 4
end

first, second, last = returns_four_values()
print(first)
print(second)
print(last)
-- the '4' did not get assigned hence it is discarded
```

<p align="center">Condition</p>
```lua
local function action(x)
  if x then
    print("x is truthy") -- when x = true; 0; {}
  else
    print("x is falsey") -- when x = false; nil
```
<p align="center">Modules</p>
There isn't anything special about modules, they are just simply files!
```lua
-- foo.lua
local M = {}
M.cool_func = functions() end
return M
```

```lua
-- bar.lua
local foo = require('foo') -- assume foo.lua and bar.lua are in the same directories
foo.cool_func()
```
<p align="center">Metatables<\p>
A thing that contains information about a table
```lua
__add
__index
__newindex(self, key, value)
__call(self, ... )
```
