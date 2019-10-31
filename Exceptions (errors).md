# Exceptions (errors)
## Handling Exceptions
Errors (exceptions), like everything else in Ruby are objects and have a class hierarchy. All share the `Exception` ancestor.
Some common error hierarchies are:
- `RuntimeError` < `StandardError` < `Exception`
- `NoMethodError` < `NameError` < `StandardError`
- `TypeError` < `StandardError`
Ruby uses a constant variable `$!` which stores the most recent error raised.
### Rescue
If a code block is given a `rescue` block and an error occurs, the interpreter thread will continue on in the rescue block. You can define a rescue block with `begin/end` or just `rescue` on its own
Rescue blocks need an _explicit_ return statement
```rb
def divide
  begin
  num = 10/0 # code that may go wrong
  rescue
 # will  throw to here if errors out
    return "can't divide by 0" # explicit not implicit return
  end
end
```
You can also fire off code in the event errors _don't_ occur, by adding an `else`.
```rb
def divide
  num = 10/2
  rescue
    return "error occured"
  else
    puts 'no errors here'
end
```
### Named rescue blocks
This way of dealing with exceptions is too generic and doesn't give a programmer insight into the actual issue.
Named rescue blocks provide a way to overcome this problem.
If we provide rescue a name e.g a type of exception class we can get more details. Only errors of that type will cause that block to run. If such an error occurs the block is called with that exception.
```rb
# risky code
rescue StandardError => e
    puts e.message
    return 'error occured'
end
```
For handling different errors you can provide a list of named rescue blocks:
```rb
  rescue StandardError => e
    puts e.message
    return 'a standard error occured'
  rescue  RunTimeError => e
    puts e.message
    return 'a runtime error occured'
end
```
Rescue blocks have a few specific behaviours that should guide how we write them:
- Exception clauses are evaluated in order.
- Subclasses are matched against their superclass.
More specific types of errors should be specified at the top, then more generic.
A generic `Exception` rescue block would  
a) be too broad, you can't tailor functionality
b) catch all exceptions including `TypeError` and `SignalException` which would mean you couldn't `cntrl d` to escape and would have to use `kill -9` 😱
### Backtrace
If you've smoothed over the error and are just logging the message, `backtrace` provides call stack for the point where the exception was raised using `e.backtrace`.
### Ensure
If you want to do something regardless of whether a piece of code is successful or not e.g close a connection you can use `ensure`
```rb
ensure
  connection_open = connection.open()
  rescue SystemCallError => e
  # handle error
    return 'error opening connection'
  ensure
  connection.close if connection_open
```
## Raising Exceptions
We can throw exceptions using the `raise` method from object class (or its alias `fail`)
`raise` gives you a few options:
- pass it a string and it will create a `RuntimeError` and set your string as the error message e.g. `raise 'my message'`
- give it another `Error` class and a string, and `raise` will instansiate that error `type` with your string as the error message e.g. `raise Exception.new 'my custom message'`
- `raise` called without arguments will raise the most recent exception stored by `$!`.
### Creating custom Errors
You can create custom error classes which inherit from standard error to make sure its caught by default.
Calling `raise` without arguments in this custom error example will simply print the message of the most recent error then cause it to throw
```rb
class MyErrorClass < StandardError
end
begin raise MyErrorClass.new 'using a custom error!'
rescue MyErrorClass => e # will now be tested against its superclass StandardError
 puts e.msg # => using a custom error!
end
```
### Retry
Lecture: Consider you get an exception from an api or database call. You might want to try a couple of times just incase it was a blip. but you don't want to create a messy loop to keep trying...
`retry` which will go back to the beginning of the method or `begin/end` block
The following snippet combines `retry` with rescue
```rb
  apiCall()
  rescue RuntimeError => e
   attempts ||=0 # if first time block is run attempts=0 if a retry execution, keep attempts whatever it was...
   attempts +=1
    puts e.message + 'reattempting request'
    if (attempts <3)
      retry
    else
      raise (MyRequestError.new, 'api request failed')
    end
```
## Throw / Catch
`Throw/Catch` is another way to raise and handle errors. A common use case is in deeply nested situations like loops as `throw` and `catch` behave slightly to `rescue` differently.
`catch`: defines a block with a given `name` or label e.g. `catch :quitRequested do...`. The block is executed normally until a `throw` is encountered.
`throw`: terminates a `catch` block with a `label` e.g. `throw :quitRequested`. The interpreter will unwind the call stack to find the named `catch` block with the matching `throw` label, that `catch` block is then terminated early.
- If `throw` is passed a second argument, that value is the return value of the enclosing `catch` - otherwise `catch` returns `nil`
- In the process of unwinding the callstack any `ensure` blocks are triggered so that resources are cleaned up
> remember: the argument of the `catch` and `throw` must match
In the below example, if the user types "quit" then the `throw` in `promptAndGet` will fire. This will unwind the call stack to find the block passed to `catch` with the matching `label`. That block now stops its execution and the output will become the string "quit" (as determined by the `throw`).
Otherwise, the method invocations will continue and output will be an array of the inputted user values
```rb
def promptAndGet(prompt)
  print prompt
  res = get_user_input
  if res == "quit" throw :quitRequested, "quit"
  return res
end
output = catch :quitRequested do
  name = promptAndGet("Name: ")
  age  = promptAndGet("Age:  ")
  sex  = promptAndGet("Sex:  ")
  # process information
  [name, age, sex]
end
```
## Resources
[Nice article on error handling](http://ruby.bastardsbook.com/chapters/exception-handling/)