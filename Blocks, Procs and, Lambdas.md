# Blocks, Procs and, Lambdas
Ruby has a variety of ways to define quick "throw away" functions: these are `blocks`, `procs` and `lambdas`. These are different from traditional methods which are most easily spotted by the use of `def` and `end`.
## Blocks
> Ruby blocks are little anonymous functions that can be passed into methods.
The only way to use `blocks` is to pass them as arguments to a method.
### Anatomy + Behaviour of a block
- A `block` is a piece of code between `do - end` key words or between `{}`
- Blocks are not saved to variables!
- Block `parameters` are always specified between `||` at the start of the block
- `Return` key word will exit the enclosing / calling context (generally `blocks` don't use `return`)
- Blocks are not strict on arguments - pass too few, and extras will be filled with `nil` or default parameters. Pass too many and it will ignore them
- To pass a block as an argument you simply provide it next to the function call
```rb
5.times {|x| return x}
      # ^ --------- ^
      # this is a block being passed to the `times` method
```
Passing an anonymous block like this isn't considered an explicit argument - rather an implicit one. So if you have a method expects one parameter, and you pass a block - you will get an argument error.
To execute a `block` argument need to use the `yield` keyword
LECTURE: yield will go and find implicit block argument and invoke it for you
```rb
def invokes_provided_blocks
    yield
end
invokes_provided_blocks {puts 'hi'}
# output ->  hi
```
## Procs
> `Blocks` are instances of `Procs` and are effectively named `block` objects. The benefit of this is it helps them get passed around as variables.
Like `blocks`, `procs`:
- are not strict on arguments
- `return` will exit the enclosing / calling context (generally `procs` don't use `return`)
### Making a proc
- Save a `block` to a variable with the `proc` or `Proc.new` qualifier
```rb
 my_first_proc = proc {|x| x+=1}
 # => creates: <Proc:0x007ffb12907940@(irb):1>
 # NB. this is really a method in the `Kernel` class:
 # Kernel.proc { |x, y| x + y }
```
Naming an anonymous `block` argument as a parameter is one way to get a proc (using `&` syntax). As soon as you want to access a block passed by name, it becomes a proc with this syntax.
```rb
  def will_accept_block(&now_a_proc)
  # if will_accept_block was passed a block the &name syntax has converted it to a proc using under the hood .to_proc method call
  # the reverse is also possible using `&`
  end
  will_accept_proc { *this is a block *}
```
### Invoking procs
There are a variety of ways to invoke a proc - most importantly you can't use `yield` as before.
```rb
p  = Proc.new( {|x|} puts x)
p.call "yay"
p.yield "wow!"
p.('more')
p['whats going on']
```
### Converting symbols into procs
`&` syntax can also convert a symbol into a proc.
A case example would be like passing `Number` to `map` in javascript.
```rb
['hello'].map {|word| word.upcase} # ['HELLO']
#alternative
['hello'].map {&:upcase}  # ['HELLO']
[1,2,3].reduce(1) {|total, n| total+n} # 11
#alternative
[1,2,3] reduce(0, &:+) # 10
```
## Lambdas
Lambdas are ultimately another way to covert a `block` into a named object.
They are more similar to a standard `method` (i.e. `def` / `end`):
- (sometimes)Parameters are defined _outside_ main block code `|params| {*block code*}`
- Strict on arguments / parameters matching
- `Return` will exit the `lambda` and continue on in the calling context.
### Creating a lambda
Under the hood converts a block into a proc but with some extras
- `lamda {}`: `l = lamdba {|z| puts z}` - if using lambda syntax, parameters go inside the code block.
- `->` known as `stabby` : `another_l = ->(y){puts y}`
## Scoping rules
Parameters in any of these types of functions shadow variables of the same name in outer scope.
Variables declared in the body of the function overwrites variables of the same name in outer scope
To get around this you can list all the variables you want to shadow using `;var_name` in the parameter list
```rb
class User
  def outer_method(name)
    save_user do |name|
    # name is now shadowing - a local variable and doing things to name in the block won't affect the outer_method name parameter
  end
  def outer_method(name)
    save_user do |x|
    name = 'hi'
    # name is now overwriting the outer_method name parameter, not creating a local variable name in the block
  end
  def outer_method(name)
    save_user do |x; name|
    name = 'hi'
    # name is now again shadowing and considered a local variable
  end
end
```
## Differences between the 3
| Attribute                                                   | Block                      | Proc                       | Lambda                               |     |
| ----------------------------------------------------------- | -------------------------- | -------------------------- | ------------------------------------ | --- |
| Named?                                                      | No                         | No                         | Yes                                  |     |
| Invoked using                                               | `yield` / `yield(args)`    | `.call()` / `[args]`       | `.call()` / `[args]`                 |     |
| Strict on arguments provided?                               | No                         | No                         | Yes - like a classic method          |     |
| Able to be passed around as named arguments / return values | No                         | Yes                        | Yes                                  |     |
| Return exits out of                                         | enclosing context / thread | enclosing context / thread | lambda's (it's own) context / thread |     |
Some more points:
> `procs` behave similarly to `blocks`
> the main reason for a `proc` is to have a named `block` you can pass around
> `lamdbas` are more like `methods` (except they can be anonymous too)
> `return` and `break` work differently in `procs`/`blocks` and `lambdas`: good idea to avoid return + break in blocks and procs
## Resources
[A good Medium article on the 3 functions](https://medium.com/@matjack9/ruby-some-closure-on-blocks-procs-and-lambdas-4e53becd0c78)