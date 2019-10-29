# Hashes (or dictionaries)
Hashes are an ordered collection of `key:value` pairs.
The order is determined by insertion order
## Syntax
Create a hash literal with `{}` or `Hash.new()`
Keys and values are separated by `=>` or in some cases a colon `':'`
To access hash properties you use `[]` notation
- Hash.new can be passed a value which will act as the default value of a key -- otherwise it will default to nil
- You can use computed key values to access a hash
- Can use `[]`to update or add entries
### Keys
Hash keys have to be either:
a) strings  
b) :symbols  
c) numbers
Whether you choose strings, symbols or numbers this determines how you access the hash
e.g.
```rb
hash = {:"string_symbol_key": 1}
hash["string_symbol_key"] #  => nil
hash[:"string_symbol_key"] # => 1
```
> The `key: value` syntax is a shortcut for using a symbol as the key - there is no need for the `=>` in this context
## Enumerable
Hashes have the Enumerable class mixed in so many of the iterator methods are also available on classes. e.g. `each` to iterate over key / value pairs
```rb
pets = {:cat => 1, :dog => 2}
pets.each {|v| puts v} # [:cat, 1] --> [:dog, 2]
pets.each {|k,v| puts "#{k} - #{v}"} # cat - 1, --> dog - 2
```
## Resources
Here's a useful [list](https://www.tutorialspoint.com/ruby/ruby_hashes.htm) of some great methods
[Introduction to Hashes in Ruby, and in Rails - EPFL Extension School - Medium](https://medium.com/epfl-extension-school/introduction-to-hashes-in-ruby-and-in-rails-be8ac5d4f58a)