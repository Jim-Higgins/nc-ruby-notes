Conditional Logic
If statements
You can use an if statement to enact some code conditionally
​
Much like in javascript and c# there is also else, and elsif. Ternaries are also available.
​
if has a counterpart unless which negates if
​
e.g.
​
if true  # --> always runs
unless true # --> never runs
unless false #  --> always runs
Ruby has a concept of truthy / falsey, but not many things are falsey (e.g. 0 is still truthy, so better to be explicit)
​
All conditional logic needs an end (but no do) e.g.
​
  if condition
    # do thing
  else
    # do other thing
  end
There is no block scoping for variables defined in a conditional block
​
Conditional flow control operators
Ruby has an ung-dly number of comparison and flow control operators. and, &&, or, ||, <=> are just a few of them.
​
Things to note:
​
Ruby uses short circuit evaluation, so if the left side of an && fails, the right side is never evaluated
and and or have lower precedence than && and || - better to use && , ||
|| can be used in the conditional initalisation of variable: name ||='default'
case statement
Ruby's version of switch statement is called the case statement. e.g.
​
Whens can be conditions, exact values, regular expressions,ranges etc...
​
case 'edinburgh'
  when /manchester/
    puts 'alright our lass'
  when /edinburgh/
    puts 'i dinny ken'
  else
    puts 'my stereotype knowledge is somewhat limited'
end
​
## -> 'i dinny ken'
Cases are evaluated in order, so the more specific ones are better placed early on