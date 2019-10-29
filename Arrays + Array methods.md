# Arrays + Array methods
## Enumerable
Enumerable is a module that has loads of methods available. Its been mixed into the array,hash, range interfaces:
- Enumerable allows you loop over subsets of elements in different ways e.g `each_cons` -> will iterate over each 2 element part of the array and treat it as a sub array e.g.
```rb
[1,2,3,4].each_cons(2) {|value| puts value}
# [1,2] --> [2,3] --> [3,4]
```
- there are approximately 50 methods available
- e.g. `map` , `reduce`, `sort`, `select`
[Cheatsheet](https://www.shortcutfoo.com/app/dojos/ruby-arrays/cheatsheet)