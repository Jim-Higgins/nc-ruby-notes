# Singleton patterns, Eigenclass and Metaprogramming
A `singleton` method is a method that is attached to only one specific instance of an object. It cannot be called by any other instances of that object, nor directly by the class itself.
```rb
otis  = Dog.new
  def otis.get_over_excited
    puts 'wag wag wag'
  end
```
Whenever you declare a `singleton` method on an object, Ruby automatically creates a `class` to hold that method and bind it to that instance. This class is known as the `Singleton class` - or `Eigenclass`. In some contexts this is referred to as the meta-class - hence `metaprogramming`. This `singleton` class sits between the instance and original class in terms of hierarchy.
```rb
otis.class # => Dog
otis.singleton_class # => #<Class:#<Dog:0x00007f80181aad48>>
otis.singleton_class.ancestors # => #[<Class:#<Dog:0x00007f80181aad48>>, Dog, Object, Kernel, BasicObject]
```
All objects can have anonymous (or `singleton/eigen`) classes wrapping around them. This `eigenclass` keeps track of any `singleton` methods (as opposed to instance methods).
Whenever you invoke a method on an object, it _first_ looks to see whether the method exists in its `eigenclass`. If not found, the interpreter will move onto to the instance methods of the object, and so on in the inheritance hierarchy.
## Static methods and the EigenClass
A question you may be asking is: what about static methods using `self.method_name`? This syntax upon inspection looks similar to the singleton declarations above.
Well a class is an object like anything else in Ruby. Classes are ultimately instances of a class called...`Class`. Any static method defined on `self` is really just a singleton method for on a class object.
When using the `self.method_name` to define a class method, we're adding this method to the wrapper `eigenclass` of the class itself.
When you call that static method e.g. `Dog.bark` it must be looking at its singleton methods in this wrapper
Another way to define singleton method i.e. static class method is like so:
```rb
class Dog
  class << self # This opens up Dogs anonymous singleton class for edition. We set the self (i.e the class Dog) to this anonymous meta (singleton) class. any methods we write now will be added to the list of instance methods on the singleton class, which as we now know is bound to the self i.e. Dog so will be callable on Dog.
    def get_over_exited # now a static method available on Dog
      puts 'wag wag wag'
    end
  end
end
```
### Resourcecs
[A great article about singleton patterns in Ruby and metaprogramming](https://yehudakatz.com/2009/11/15/metaprogramming-in-ruby-its-all-about-the-self/)