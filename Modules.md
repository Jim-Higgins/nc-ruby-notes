## Modules
Modules are ultimately a collection of anything from methods, constants, class variables to actual classes.
They are created using the `module` key word.
```rb
Module MyCoolModule
  # put classes, methods, constants anything here...
end
```
### Some rules about modules:
- modules cannot be instansiated
- modules cannot inherit, nor can be extended
- all classes are inherit from modules, but modules are technically classes (say what!)
- modules, like classes have to start with a capital letter
- to access a constant inside of a module you use the `::` scope operator - use much like dot notation
Modules are ultimately used for 2 reasons: `Namespace` and `Composition`. Modules can:
- bundle related objects
- provide namespaces to resolve name clashes - this often happens if you use gems which will commonly have similar named classes e.g. `application`
- add methods or information to other classes and instances
Key words for using Module composition or `mix in` functionality
- `include`
- `prepend`
- `extend`
### Include
`include` adds the module to the ancestor chain of the class its being `mixed in` to.
All the methods in the module are shared as _instance_ methods on the including class
```rb
  module Commentable
    def comment
      puts 'I love comments'
    end
  end
  class Post
    include Commentable
  end
  Post.ancestors # => [Post, Commentable, Object, Kernel, Basic Object]
  Post.new.comment # => ' I love comments'
```
`include` has risks with overwriting. Include 2 modules with the same method name, and directly accessing that method will invoke the second of the 2 modules methods:
```rb
  module Commentable
    def comment
      puts 'I love comments'
    end
  end
  module Markdown
    def comment
      puts '# i am a markdown comment'
    end
  end
  class Post
    include Commentable
    include Markdown
  end
  Post.ancestors # => [Post, Markdown, Commentable, Object, Kernel, Basic Object]
  Post.new.comment # => '# i am a markdown comment'
```
### Prepend
`prepend` acts almost exactly the same as `include`, except the module is placed in the ancestor chain before the prepending class itself
```rb
#inside Post  class
prepend Commentable
Post.new.comment # => "I love comments"
Post.ancestors # => [Commentable, Post, Object, Kernel, BasicObject]
```
### extend
Added to the ancestor chain of the singleton class of the extending class
```rb
#inside Post  class
extend Commentable
Post.comment # => "I love comments"
Post.singleton_class.ancestors # => [#<Class:Post>, Commentable, ...]