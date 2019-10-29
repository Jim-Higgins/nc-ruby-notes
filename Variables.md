# Variables
​
## Constants
​
> A Ruby constant is like a variable, except that its value is supposed to remain constant for the duration of the program. The Ruby interpreter does not actually enforce the constancy of constants, but it does issue a warning if a program changes the value of a constant
​
- start with capital letter
- if its a value e.g. max speed convention is to use all caps
- allowed to insert items into an array / hash constant
- can use freeze to ensure immutability
​
## Globals - \$
​
> Global Variables are variables that may be accessed from anywhere in the program regardless of scope.
​
- They're denoted by beginning with a `$` character
- Not very popular as it breaks the OOP concept of encapsulation, if many things rely on that one variable and its exposed to be changed, you might break many other parts of your programme
​
There are some pre-defined global variables: `$0`, `$*`, `$$`: theres a link for more info in the resources section can go read about them
​
## Variable Assignment
​
Declare name of variable and value using `name=value`. As Ruby is not strongly typed, we don't need to provide its data type.
​
All variables (except for symbols) are mutable - there is no concept of `let` or `const` as in `js`.
​
### Parallel assignment
​
You can assign variables in parallel
​
```rb
a,b = 1,2  # a=1, b=2
```
​
Under the hood this is converting the right side to an `array`, then in turn assigning each value to variable on the left
​
This means that if you do
​
```rb
a = 1,2,3 # a=[1,2,3]
```
​
BUT if you do
​
```rb
a,b = [1,2] # a = 1, b=2
```
​
## Splat (\*) operator
​
Like `rest` / `spread` operator in `js`, `*`, will collect up or spread out any collection.
​
If at end of left assignment will take all the rest of the values
​
```rb
a, \*b = [1,2,3,4] # a=1, b=[2,3,4]
```
​
If in the middle will be 'greedy' and take as many as poss
​
```rb
a, \*b, c, d = [1,2,3,4,5] # a=1, b=[2,3] c=4, d=5
```
​
If \* appears on the right hand side of an assignment, \* it coverts those objects into an array.
​
e.g
​
```rb
a,b,c = 1..3 # a= 1..3, b=nil, c=nil
# BUT
a,b,c = *1..3 # a=1, b=2, c=3
```
​
You can also splat operator to spread out contents of a collection.
​
```rb
r = (1..5)
[1,2,*r] # [1,2,1,2,3,4,5]
```
​
## Resources
​
[More about splat operators](https://www.freecodecamp.org/news/rubys-splat-and-double-splat-operators-ceb753329a78/)
​
[More on global variables](https://www.thoughtco.com/global-variables-2908384)