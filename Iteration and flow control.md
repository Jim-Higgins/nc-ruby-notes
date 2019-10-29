# Iteration and flow control
​
Ruby has a bunch of ways to control the flow that will feel very familiar based on c# and javascript.
​
Variables declared in these flows are not block scoped, except for defined parameters (`|x|`)
​
All loops have return values. In most cases this will be `nil` or just the thing you iterated over in the first place.
​
## While loops
​
Keep running code until a condition stops being true. Here's an example of a basic `while` loop.
​
```rb
while condition do
 # run code
end
```
​
If code can fit on one line you still need `do / end` _BUT_ you can use an altered format to make it even more concise:
​
```rb
<code> while condition?
```
​
Like conditional logic, `while` has a counterpart `unless` which inverts the condition e.g.
​
```rb
while false #=> never runs
unless false #=> always runs
```
​
## Iterative loops
​
### each method
​
Each method is can be called on different `iterable` collections that have the `Enumerable` module.
Pass it a `block` (effectively a function, we'll cover this in detail soon) and it will execute that function on each item in array.
​
```rb
[1,2,3].each do |num|
   # code
end
```
​
### for
​
For loops are considered syntactic sugar over the each method. For loops also take a block function which will be executed on each iteration.
​
```rb
for i in (1..10) do |i| # or an array
     #code
end
```
​
### Number iteration
​
There are some iterative methods available on numbers
​
- `upto`:
​
```rb
10.upto(15) do |i|
    # function executed 6 times (inclusive of 10 and 15)
end
```
​
- `downto`: `10.downto(5)...`
​
- `times`: `10.times...` --> execute block 10 times
- `step`: `1.step(10,2)...` --> custom increments up to 10 --> here jumping 2 each time (so will print odd numbers)
​
## terminating + skipping + repeating
​
Sometimes you don't need to evaluate, or need to redo some logic in a loop: Ruby provides some nifty key words to handle this:
​
- `next`: starts the next iteration of the loop without finishing the execution of the current iteration code
- `break`: terminates loop - you can pass an argument to break and that will become the return value of the loop
- `redo`: moves execution to start of the block without re-evaluating the loop condition