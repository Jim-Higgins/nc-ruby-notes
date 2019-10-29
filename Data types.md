# Data types
​
## Booleans are just booleans
​
Ruby has a concept of truthy / falsey values, but not many things are falsey (e.g. 0 is still truthy)
​
## Numbers
​
### Integers
​
Ruby had 3 classes to represent integers `Integer`, `fixnum` and `bignum` (these 2 are now deprecated but you may find it in legacy code) both inherit from `Integer`.
​
- `fixnum` your basic integer up to a certain size
- `bignum` This is much larger and only limited by available memory
​
If a `fixnum` has a calculation applied and gets too big it will automatically be converted to `bignum`
​
If you calculate 2 Integers, you will always get an Integer e.g.
​
```rb
3/4 # => 0
```
​
### Gotchas
​
A tripping point is that numbers are immutable objects, so even though there is an increment operator, its not mutating the original number object...
​
```rb
def add2(n)
  return n+=2
end
​
num=2
add2(num)
# num == 2 --> true
```
​
### Float
​
According to Ruby's own documentation floats are... "imprecise" due to rounding errors. However there's not much surprising about them, they as ever have many methods available.
​
> If you mix floats + integers in a calculation you will always get a float
​
```rb
2-1 # => 1
2.0 - 1 # => 1.0
```
​
---
​
## Strings
​
In ruby strings are objects, instances of `String`.
​
String class has ~100 methods.
​
- `single quotes`: Only has 2 escape values available: `\'`and `\\`
- `double quotes` -> allows more escape values e.g. `\n` `\t` `\"`
​
There are also a few other ways to [make a string](https://www.techotopia.com/index.php/Ruby_Strings_-_Creation_and_Basics)
​
---
​
### String Concatenation + interpolation
​
`Concatenation`: To be able to concatenate values, _everything_ needs to be a string. If you want to have a string with a number variable you have to coerce it to string using `to_s`
​
```rb
age = 20
msg = 'i am' + age.to_s + 'years old'
# => 'i am 20 years old'
```
​
`Interpolation`: Embedding evaluated Ruby code in a string. Interpolation will automatically coerce other data types to string. Interpolation only works with double quotation marks.
​
```rb
age = 20
msg = "i am #{age} years old`
```
​
### Multiline strings - `heredoc`
​
Ruby follows classical Unix treatment of multiline strings which preserve whitespace.
​
`Heredocs` Support string interpolation
​
Use `<<` syntax to start to start a multiline string. Choose a custom `terminator` or `delimiter` to signal the start and end of a multiline string
​
```rb
hamlet = <<myCustomTerminator
  ACT I
  SCENE I. Elsinore. A platform before the castle.
  FRANCISCO at his post. Enter to him BERNARDO
myCustomTerminator
```
​
### String Methods
​
Here are some quick ways to access or manipulate strings.
​
- `[]`: to access a character or substring. Can be used to reassign that item
- `*`: create a string n times --> `'a' * 3` --> `'aaa'`
- `.chars` --> array of characters
- `.split($seperator)` --> array of substrings by seperator
- `.upcase` & `.downcase` --> if followed by `!` determins whether mutating :
  - `upcase!` will mutate the original string object,
  - `upcase` will return a new uppercase string object
- `gsub` --> replace all occurrences of a substring with a new substring (extra powerful with regular expressions)
​
## Symbols
​
Symbols in Ruby are special kind of object: a mix between a constant and a string.
​
> The first time you use a symbol, an object is created, now whenever you refer to that symbol, its referring to the same object
​
Each `symbol` is a `Symbol` instance, created by
​
- `:identifier`
- `:"string_identifier"` --> this version can use an interpolated string
​
**Symbols are globally unique and immutable**
​
As such, symbols are a good substitute for strings especially when the string is used as a label e.g. `my_func(:name)`
​
In these situations `symbols` are more efficient than `strings` because a new `string` object would have to be instantiated each time. With `symbols` it's just a matter of checking reference, whereas with strings you have to check contents
​
Symbols are often used as function parameters - esp when the parameter can be one of a small set of values like `:sort_order`
​
You can use `to_s` to convert a symbol back to a string, and reverse `to_sym`
​
## Ranges
​
A range is an object which has a starting value & ending value. e.g. `1..3`. When applied to some logic this ranger will denote numbers from 1 - 3.
​
Range values do not have to be numbers e.g. `a-d` will denote letters `a-d`.
​
- `..` inclusive range or `...` exclusive (upper boundary excluded)
- Ranges have the `Enumerable` module meaning have access to many iterable methods e.g. `map` --> in this case `map` will map over an array representation of the range and then return an array
​
## Arrays
​
Arrays act in Ruby much like they do in Javascript.
​
Declared with:
​
- `Array[]`
- `[]`
- `Array.new` (will give empty array)
- `%w()` --> will create an array from a string of spaced words
- `%i(labels)` --> will create an array of symbols
- `Array.new`(num_of_index_to_populate, default_value_to_populate_with)
  Note this last syntax is a little risky, because you will be providing a value which will have a reference copied across all items in the array e.g.
​
```rb
arr =Array.new(2, 'abc')
# arr -> ['abc', 'abc', 'abc']
arr[0].upcase
# arr -> ['ABC', 'ABC','ABC'] because every element referred to the same objet
```
​
To provide defaults, it is to provide a block `arr =Array.new(2) {'abc'}` => each item will now have its own `abc` string object
​
### Methods / Accessing
​
We will be going into more depth about the available methods with arrays and other iterables but here are some initial useful methods.
​
- `[]` syntax to access items, with `[-1]` counting form the back
- can modify items in the array by index -> `array[0] = 'kevin'`
- use ranges to slice an array `arr[1..4]`
- use ranges to replace items in an array `arr[1..2] = ['new, value]`
- `+`: join arrays together
- `*`: duplicate contents and push into a new array
- `-`: copy array remove specified items in array e.g.
  `[1,2,3,2] - [2]` -> `[1,3]`
​
## Hashes (or dictionaries) - we will have a section on this later
​
## Regular expressions
​
Regular Expressions aren't much different in Ruby to other languages. They belong to a `Regexp` class which you can instantiate using
​
- `//`
- `%r()`
​
### Useful methods
​
- `~=`: test for match in a string --> will return the _position_ of the match
- `!~`: test for absence of match --> will return boolean
- `/regex/.match(str)`--> get more info about the match, not just position
- `pre_match` and `post_match` available
- `scan`: return array of substrings (NB: this is actually a string method but is more powerful with regular expressions)
- `gsub`: replace substrings, for complex things can take a function block