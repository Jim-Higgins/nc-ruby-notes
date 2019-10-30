# Messaging: An alternative OOP concept
In OO, "making a call", "invoking a method", and "sending a message" are equivalent concepts. Similarly "being called", "having one's method invoked", and "receiving a message" are equivalent.
Alan Key who coined the term object oriented and invented SmallTalk (an early OO language) [expressed regret at the term OO which focuses on objects instead of messages](http://wiki.c2.com/?AlanKayOnMessaging)
When talking about a message, there's a natural "sender" and "receiver" of the message. The `sender` is the object which invokes a method, the `receiver` is the object whose method is invoked. In Ruby, if one calls a method without explicitly naming an object, that sends the method name and its args as a message to the default receiver `self`.
[Joey GIF](https://i.imgur.com/F8mc7a3.gif)
## Messages, Receivers, Senders
```rb
a= "this is a string"
a.reverse
a.send(:reverse) # equivalent
```
There are 3 properties to consider:
- message: reverse is the message - each message will correspond to a method
- receiver: the receiver of the message - the instance of the string class`a`
- sender: the object where all of this is called - the object `self` in this case in the global `self` which is `main`
If we move the same code into a class
```rb
class Example_Class
  a= "this is a string"
  a.reverse
```
The only thing that has now changed is the object responsible for sending: the sender is now `Example_Class`
The `receiver` defaults to `self` unless otherwise specified.
## Programmatic Function calls
This idea of function invocations being sent messages allows for the dynamic invocation of different messages if you use the `send` method. Consider the following example which could be used in dealing with queries on an api:
```rb
a=[1,2,3,4]
input = {limit:2}
handlers = {
  "limit": :slice,
}
puts a.send(handlers[input.keys[0]], input.values[0]..-1)
 # now calling a different method on a based on user input
```