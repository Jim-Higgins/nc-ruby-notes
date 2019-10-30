# Intro II
## Method visibility
In line with the concept of OOP abstraction Ruby has ways of limiting the access to specific methods (and therefore variables too)
By default any class we declare will have a host of public and private methods, we can check these out using `Class.instance_methods` and `Class.private_methods`.
In Ruby we have the option to make any method adhere to 1 of 3 visibility rules:
- `public`: can be called inside the Object (e.g. inside methods) or on the instance
- `private`: can only be called from within the Object not outside (e.g. on the instance).
- `protected`: can only be called from the scope of an Object of the same Class - not used very often
All custom methods are set to public by default
### Private
Lets take the example of a Customer class. In some cases we'll be happy for some data to be publicly viewable and some not so much.
```rb
  def initialize(name, password)
    @data = name,
    @password = password
  end
```
To make a method private can define it actively `private :get_password,`
Can use `private` without method name and will define all methods after the declaration will be private
```rb
attr_reader :name # public default to public getter
end
private # all methods below are now private
def password
end
def pin_number
end
```
If you try to call a private method outside the class (e.g. on the instance for example) you get an error
## Messaging and visibility
When considering private methods: under the hood, the difference is that they are not available for explicit receivers consider the following examples:
```rb
class Manager
  def call_meeting
    fire_employee # here the private method is being called with the implicit receiver of `self`
  end
  private
  def fire_employee
    puts "you're fired"
  end
end
manager = Manager.new
manager.call_meeting # => will output you're fired
# ---------
class Manager
  def call_meeting
    self.fire_employee # even though receiver of `self` is the same, explicitly defining it will mean privacy methods will block fire_employee's invocation
  end
  private
  def fire_employee
    puts "you're fired"
  end
end
manager = Manager.new
manager.call_meeting # error
```
Some warnings:
- Subclasses: Private methods _are_ accessible from subclasses.
- Overwriting: When overwriting methods, visibility restrictions don't continue: if a method was original private and you overwrite it, the new method is still by default public
- Class methods: If you use regular `private` declaration on a class method it remains publicly viewable - this is due to the context involved with `self.` notation which we'll cover in more detail tomorrow. For now if you want a private class method use `private_class_method :get_password, :get_secrets`.
## Class-Instance methods + variables
If you use instance (`@`) variables and declare them in the body of the class this now becomes a hybrid `class instance variable`.
Importantly, these are available on the class, but behave more like a instance variable
In `class` variables all classes and subclasses shared one variable, in `Class instance` variables the `Parent` class and each of the `subclasses` get their own copy of the variable - but only one per class.
```rb
class Animal
@legs = 4
  def self.getLegs
    @legs
  end
end
class Insect < Animal
  @legs = 6
end
Animal.getLegs # 4
Insect.getLegs # 6
```
Class-instance variables:
- accessible only by class methods
- not shared on inheritance (though the `getter` method still is as this is a normal static method!)
- not used often
## Resources
[This page expands on class instance variables and how they differ to classes](https://www.ruby-lang.org/en/documentation/faq/8/)
[Why `private` doesn't work on class methods & ways to resolve it](http://jakeyesbeck.com/2016/01/24/ruby-private-class-methods/)