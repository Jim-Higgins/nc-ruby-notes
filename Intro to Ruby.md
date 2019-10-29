# Intro to Ruby
​
## What is ruby
​
Ruby is a dynamically typed and interpreted language. There's no compiling and its "loosly" typed. Ruby is much closer to javascript than c# in strictness.
​
Ruby comes with many different options of interpreters:
​
- `Ruby MRI` or `CRuby`: This is the standard version of Ruby and is the default installed on many systems including MacOS. It's developed in C by the creator Yukihiro Matsumoto.
- `JRuby or java ruby`: This is an implementation on top of the java virtual machine (JVM)
- `MRuby`
- `ruby motion`
- `REE (Ruby Enterprise Edition)` : RIP this was discontinued in 2012.
​
There are a variety of reasons why one interpreter may be picked over another such as boosts in speed or memory utilization.
​
Rails, is really popular framework in Ruby, used to run on `REE` but with it being discontinued migrated to RubyMRI. As such availability of certain frameworks may also be a factor in choice of interpreter.
​
## Ruby philosophy and flexibility
​
Ruby's main philosophy is to trust the developer. Very few rules are strictly enforced and only done by convention. This of course provides equal freedom and responsibility on the developer.
​
Ruby is an _incredibly_ flexible language and many types of programming: OOP, functional, and procedural.
​
- TMTOWDI - Meet your new moto - `There's more than one way to do it`. In Ruby things a dozen ways to do any singular thing this is the bread and butter of what we'll be unpicking today.
​
# The Ruby Eco System
​
`irb - Interactive Ruby Shell`: is a REPL for programming in Ruby. Use `ctrl d` to quit.
​
## Project Structure
​
- `lib` - actual components of the project
- `doc` - any documentation for the project
- `test` / `spec` : tests
- `bin`: contains executable utilities e.g. bundle
- `init.rb` : main file that kicks off application logic.
​
## RubyGems - 3rd party libraries
​
`RubyGems` are like node_modules in js - 3rd party library code we can use in our projects.
​
They can be globally or locally installed we're only going to be using a testing framework for a few days so we'll rely on global installations.
​
Local ones will be in the `vendor/cache` directory (we'll see this in a few days) and is often used for larger / deployed / things being shared across teams projects
​
[Rubygems](https://rubygems.org) is the main place to look for ruby gems.
​
Newer Ruby versions by default comes with the `gem` command available to interact with `RubyGems`. The gem command is useful for searching + installing `gems`
​
Here's a list of useful terimal `gem` commands:
​
- `gem search -r <name>`: search for gems
- `gem list`: list globally installed gems. Use `-i` tag to search if you have a specific `gem` installed
- `gem server`: start a local server on `8080` to list gems with more detail including links to their github repos
- `gem install <gemname>`: download a gem. This command also installs any dependencies that a gem requires and also installs the documentation for the gems
- You can download and peruse a gem without installing it proper using `fetch <gemname>` then `unpack <gemname>`
​
## Bundler
​
`Bundler` is a gem itself, it acts as a gem manager - much like `npm` in javascript.
​
Bundler manages `gem` versions and all `gems` needed for a project and much more.
​
To use bundler you need to install it using `gem install bundler`
​
---
​
### Installing gems with Bundler
​
Bundler relies on the presence of a `Gemfile`. This is a file that `bundler` uses to read what gems you need. Things a `Gemfile` needs:
​
- The source of where to look for gems - the standard source is `rubygems.org` - but you can also specify other sources like github directly
- a list of all gems you need `gem <gemname>`
​
> The `bundle init` initialize a project with a Gemfile set up for you
​
To install using bundler use the `bundle install` command. This will:
​
- Read the `Gemfile` and install all the gems specified
- Create a `Gemfile.lock` which tracks all the versions and dependencies your desired gems depend upon
​
Once installed you're free to use those gems. They will likely have `executable` commands (listed on the `gem server`) that you can use in the terminal for example the executable for `rspec` ... is just `rspec`