# Intro to OOP and Classes in Ruby
Object Oriented Programming (OOP) is a programming paradigm that represents the entities of a system as objects. There are many resources out there about the concepts that contribute to OOP, but the 4 main pillars are:
- `Encapsulation` - Bundling data and operations into an entity
- `Abstraction` - Exposing only the relevant details of an entity
- `Inheritance` - Deriving a new entity from an existing type - thus drawing upon existing information and behaviors
- `Polymorphism` - Entities taking on different meanings in different contexts
## Classes and Objects in Ruby
One can think of classes as a blueprint, detailing all the information (variables) and behaviors (methods) anything of a certain _type_ should have.
In Ruby an `Object` is an `instance` - a real copy made from the blue print outlined by a class. Any object can have access to information and behaviors defined in a parent class - this is what we mean by `inheritance`
Something we've been skimming over so far is `Objects` in Ruby. Technically, everything in Ruby is an object - everything stems from a common `ancestor`, the `BasicObject` class. Unlike javascript where there is a distinction between primitive types and object types, all values in Ruby are Objects and will have their own id reference.
To prove this you can look at the `superclass` property on any class. We'll go into depth what `super` means but for now you can think of it as the parent class
```rb
Array.ancestors
# [Array, Enumerable, Object, Kernel, BasicObject]
Array.superclass #=> Object
Object.superclass #=> BasicObject
BasicObject.superclass #=> nil
```
## Creating a class
We define classes much like we do a method, just replace the `def` with `class` and you've got a class.
One of the few times where something is strictly enforced in Ruby is the naming of our classes - they must begin with capital letters or we'll get a `SyntaxError`. By convention class names are nouns so `User`, `Customer` etc.
NB: notice the capital letter on that error? Errors are classes too which we will look at later
```rb
class Bird
end
```
Thats all you technically need to make a class. Unlike `c#` there's no need to define whether a class is public or not, visibility will come in later.
To initialise a Bird object - to make an `instance` Ruby uses the new key word. This will return a hexadecimal number of the id of that object.
To prove that you can use this: `'0x%x' % (object_id << 1)`
```rb
my_first_bird = Bird.new
# => <Bird:0x00007fd937214950>
```
Here 2 bird instances have been made and when we compare them and you can see that they're not the same. We can, however, prove they are derived from the same ancestor by using `.class`
Appending `.class` to the instances on line 56, reveals that the instances shared ancestor is the same.
```rb
my_first_bird = Bird.new
my_second_bird = Bird.new
my_first_bird == my_second_bird # false
my_first_bird.class == my_second_bird.class # true
```
## Instance Methods and Variables
Lets say you want your all birds to be able to `talk`. 
When we're designing a new piece of functionality, your focus should be on the way we can interact with that functionality: the exposed API. A way to think of the Bird interface for this would be to be able to call a `talk` function on the bird.
```rb
my_first_bird.talk
# Remember that in ruby you can invoke a function without the parentheses ()
```
Currently this is will error with a `NoMethodError` as we haven't outlined a talk function on our `Bird` blueprint.
To define a method on a class we use `def/end` and can define any expected parameters with parentheses`()` - in this example there are no parameters.
```rb
class Bird
  def talk
    puts 'squawk'
  end
end
```
Note that despite placing the method on the class, the function will only be available on our instance objects - `my_first_bird` - not `Bird` itself. `talk` is an _instance method_.
Now lets say we want our birds to `talk` their name. Our issue is that currently our Bird has no way of having its own name name.
To allow every `instance` of a class to have a variable unique to that `instance`, to allow each Bird to have their own name, we need to make an instance variable. 
NOTE:
_Instance variables_ : variables that are bound to individually to each copy of a class.
Instance variables are _defined_ and _accessed_ using `@<variable_name>`.
So lets say our `talk` method tries to access an instance variable name:
```rb
  def talk
    puts "squawk...my name is #{@name}"
  end
```
Calling this would currently give `squawk...my name is` --> There is no instance variable `name` to access so we get `nil` there. To assign variables to all our birds we have to make use of a method `initialise`.
Whenever Ruby makes a new object / instance it will look for a method named `initialise` and execute it. The job of `initialise` is to set any instance variables for a newly created object
```rb
# Bird
def initialize
  @name= 'iago'
end
```
Using `inspect` on `my_first_bird` you can see instance variables listed out
```rb
puts  my_first_bird.inspect
# => <Bird:0x00007fcb4e074b50 @name="iago">
```
> NOTE: An object having self defined information is often referred to as the state of the object.
> HINT: `p my_first_bird` will implicitly call inspect for you
`talk` will now work, but our issue now is all birds are called Iago. So lets allow the ability to pass in a name that will be associated with _just_ that bird we're creating at the time.
To pass in variables for the instance, add parameters to the `initialise` method and use that variable as the instance value:
```rb
def initialize(name)
  @name = name
end
```
> Ruby doesn't error if a class doesn't have this `initialise` method (and therefore no instance variables) and only has other methods (but we'll see later a better alternative to this).
### Getters and Setters
By default all instance variables are private. Or, more accurately, every time we've accessed a property on a Ruby object e.g. length - we're not accessing a property as in `javascript` objects, but calling an instance method which will retrieve that piece of information for us from the object's state. This is the idea of a `getter` - we can't access variables directly so we define a function to retrieve it for us.
In the example of trying to access the name property on one of our birds it will throw a `NoMethodError` - the Ruby compiler is looking for a method called `name`. Conventionally getter methods are named the same as the variable they ... get.
```rb
def name
  @name
end
```
The same principle applies for assigning any new information after the we first initialised an object. We can't assign it directly, so we need to make use of a `setter` which will take the value to assign a variable to. Since assigning a value will always make use of `=` we can incorporate this into the name of our setter method:
> Note how flexible the naming of our methods can be
```rb
def name=(name)
  @name=name
end
```
Each `getter` and `setter` will have access to only its own instances variables. If you want a variable to read only, easily done, just don't create a `setter` for it.
> There are some other conventions when it comes to getter and setters: e.g. a `?` at the end of the method name would conventionally return a boolean
### Accessors
This method of defining `getters` and `setters` for every possible instance variable would get very tedious and repetitive. Ruby has some inbuilt method that does this under the hood for us.
Inbuilt Ruby `Accessor` methods can define a list of all instance variables and will generate all the `getter` and `setter` methods for you.
There are 3 types of `Accessor`:
- `reader` - variables provided will have read only access (a `getter` method)
- `writer` - variables provided will have write only access (a `setter` method)
- `accessor` - variables provided will have read + write access
To assign a variable (or an object `attribute` - `attr`) to generate methods for you declare the type of accessor you want to use and provide it a comma separated list of strings or symbols of the relevant variables.
```rb
class Bird
  attr_accessor :name
  # initialise
  # no need for declaring getter/setter methods
```
## Inheritance
It may make sense to define the attributes of an entity in one object, but often there are variations of that object. They might share some similar aspects, but have some of their own behaviours too, or variations of the same behaviour. The `Bird` applies here too: all `Birds` might inherit their `name` or `has_beak` attribute from a parent class, but individual types of bird, or `Bird` subclasses, might define their own variables and methods, like a `can_fly` attribute or a `coo` method if its a pigeon.
Inheritance can prevent the need for duplicating data and behaviour across a codebase, but in the real world, inheritance can fail to account for the complexity of a lot of entities and systems, so codebases often favour a compositional model of assembling behaviour.
To allow a class to inherit behaviours and variables from a Parent, we use the `<`.
```rb
class Pigeon < Bird
 # all pigeons will now have a talk method
end
```
- Classes can only inherit directly from one Parent. We will later see a way to work around this limitation.
- If not otherwise specified all classes will inherit from the standard Ruby `Object` and `BasicObject` classes
- The role of inheritance in Ruby is limited compared to other languages (though quite similar to c#). One of the main reasons is to reuse functionality but not enforce interfaces.
By default when we create a subclass the parent's initialise method will be called (if it has one). So if we create a new `Pigeon` without a name argument we will get an `ArgumentError`. To set a Pigeon's name we know that the `Bird` initialise method being used will assign a name onto the instance, so we can simply pass Pigeon a name argument
```rb
peter = Pigeon.new('peter')
```
When we now access methods on any given object, Ruby will use traverse ancestors' methods, starting with the class itself, much like scope until it finds a corresponding method (or until it errors).
We can access `peter.talk` and it will search for a `talk` method on `Pigeon` before moving up to `Bird` where `talk` is found and invoked.
## Polymorphism, Overwriting, and Super
> In a programming language that exhibits polymorphism, objects of classes belonging to the same hierarchical tree (inherited from a common base class) may possess functions bearing the same name, but each having different behaviors.
### Overwriting
Often we may want to overwrite functionality as we did with `initialize`, to make behaviour more appropriate to the current entity. For example, should a pigeon really `squawk`? We can use overwriting to change our `talk` method.
```rb
# Pigeon
def talk # will implicitly overwrite Bird talk method
 puts "coo... my name is #{@name}"
end
```
### Super
---
Lets say we want extra information about pigeons, like it's `favourite_bread` - thats not something that should be shared across all birds - you hardly see people feeding Ostriches breadcrumbs. Our solution seems simple, declare a new `initialize` method that will assign instance variables only to `Pigeons`.
```rb
class Pigeon < Bird
  def initialize (:favourite_bread)
    @favourite_bread = favourite_bread
  end
end
```
Our issue now is that we've run into more `overwriting`. We've reassigned the method `Pigeon.initialize` - and it no longer sets a `name` attribute.
```rb
 my_first_pigeon = Pigeon.new('peter')
 puts my_first_pigeon.inspect
 #<Pigeon:0x00007ffaa010a098 @favourite_bread="peter">
```
We've seemingly no way to set a name without making our code WETTER - by making Pigeon `initalize` set a name even though we defined this in the Bird `initialize`. And we certainly can't pass 2 arguments representing `name` and `favourite_bread` as we've only defined 1 argument in the Pigeon `initialize` so we will get an `ArgumentError`.
_Enter `super`_
`Super` is a method. `Super` will look at the name of the method it (`super`) is invoked by, then find and invoke the corresponding method in the parent class.
If invoked with no arguments, it will by default pass all of the enclosing methods' arguments along to the parent method. This may cause an error if the argument numbers mismatch as with `Pigeon` vs `Bird`
```rb
# Pigeon
def initialize (name, favourite_bread)
 super  # will now pass name and favourite_bread to Bird initialize -> but Bird initialize only defines one parameter...
end
```
If invoked with parentheses you can determine what values to pass to the parent method. We can now continue to add any instance variables that should only be available on `Pigeons`
```rb
# Pigeon
def initialize (name, favourite_bread)
 super(name)  # will now pass name to Bird initialize
 @favourite_bread =  favourite_bread # and continue to add favourite_bread variable to all Pigeons
end
```
Inheritance only works downwards - a Parent cannot inherit behaviour or data from a subclass. So a `Pigeon` will still be able to `talk` but a `Bird` - and any other subclasses of `Bird` - won't have a `favourite_bread`. `
## Class methods and class variables
Sometimes you have functionality which is independent of the object's state.
If you always have 2 legs on a `Bird` class then you don't need to have a variable `legs` and a corresponding getter defined on every instance since `legs` will always be the same. Instead we can make use of class variables and class methods.
> A class method and variable are bound to the class itself and not on the instance object.
Class variables are assigned and accessed using `@@` and we set them by placing it in the body of the class
```rb
class Bird
 @@legs = 2
end
```
If we wanted to we could make an instance getter method for this class variable, but that defeats the point, we don't really need to make a fresh copy of that method on all instances. To declare a method accessible on the class we define it with `self.<method_name>` (we will discuss `self` later)
```rb
class Bird
 @@legs = 2
 def self.legs
    @@legs
 end
```
Now we can invoke this `legs` getter on the Bird itself
```rb
puts Bird.legs # => 2
```
> **Sadly our accessors only work for instance methods and variables**
Class variables and methods are useful as they are inherited by all subclasses
```rb
class Owl < Bird
end
Bird.legs # 2
Owl.legs # 2
```
## Final Example Code
So, bearing all the above in mind, all the refactoring and best practices, this is what our example will finally look like
```rb
class Bird
   @@legs = 2
   attr_accessor :name
   def initialize(name)
    @name = name #
   end
    
   def talk 
        "squawk...." + name
   end
    
   def self.legs
    @@legs
   end
end
class Pigeon < Bird
   def initialise(name, favourite_bread)
    super(name)
    @favourite_bread = faveourite_bread
   end
   def talk 
    'coo...' + name
   end
end
```
## Some conventions
> The only real difficulties in programming are cache invalidation and naming things. — Phil Karlton
Methods in Ruby are generally named using caterpillar/ snake case `my_fave_method`.
Since methods can have a variety of special characters in their names there are a few conventions people follow:
```rb
def name=  # a setter
def name?  # return a boolean if it exists / is a certain value
def name!  # a dangerous method that mutates
```
## Resources
This is an [excellent in depth diagram](https://i.stack.imgur.com/1taqB.png) which outlines the ancestory of the objects we're dealing with in Ruby.
[The object model in ruby](https://launchschool.com/books/oo_ruby/read/the_object_model)
[Calculations and memory allocations of object_ids in Ruby](https://tenderlovemaking.com/2017/02/01/object-id-in-mri.html)