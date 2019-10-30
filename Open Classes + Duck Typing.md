# Open Classes + Duck Typing
## Open classes
In Ruby you can 'reopen' a class to add more methods onto it. The syntax for this looks very much like you a re-declaring the class
```rb
class Author
  def get_name
  end
end
j_k_rowling = Author.new # will have access to get_name AND get_books BUT you can't call get_books before get_books is declared
class Author
  def get_books
  end
end
stephen_king = Author.new #  can now call get_books
```
## Monkey patching
> Monkey patching is the exploitation of open classes
Monkey patching used for editing / modifying functionality particularly for 3rd party functionality at runtime. You can add and overwrite methods easily.
This results in 2 things:
- fragile code: if you've edited a library then the library updates their code - things can break quickly
- confusion for larger teams: adapting a library to resolve your own problem will affect code for other programmers on your project
To resolve the second issues often alias_method is used so you still have access to the original one but can patch away.
## Duck typing
Duck typing is the concept of if it walks like a duck and quacks ...
Consider the following code:
```rb
def print_info (obj)
  if obj.class == User
    puts obj.name
  else
    puts obj.to_s
  end
end
```
This kind of type checking to ensure you don't cause any errors is okay. However, it doesn't translate so well with Ruby due to the concept of open classes and monkey patching. Theres no guarantee just statically looking at the `User` class in one file that it hasn't been reopened somewhere else and amended or the name attribute of it changed to forename.
Instead of explicitly checking the class theres a shift in Ruby to base things on behavior. Duck typing is shifting the focus to what it does, not what it is.
In this example, if you're just interested in getting the name property, you check if it has a name property without worrying about its type.
```rb
def print_info (obj)
  if obj.respond_to?(:name)
    puts obj.name
  else
    puts obj.to_s
  end
end
```
One benefit of duck_typing, is that it reduces the need to create extra wrapper classes and modules just to allow for specific interfaces.