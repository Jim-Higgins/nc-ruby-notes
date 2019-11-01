# Rack
​
## What is Rack
​
Rack is a Ruby library for building HTTP web applications and is distributed as a Ruby gem. In fact, the Rack API provides an interface for defining what the response to a particular client request should be. Rack, however, is not the same as the web server itself. In this sense, as Rack is separate from the **actual web server** ( the process listening to and processing incoming requests ). Rack can be used in conjunction with other web servers like, for example, Puma - itself a multi-threaded web sever designed for concurrent users.
​
This comes with the advantage fact that Rack is very simple to set up and start using. However, it is disadvantageous because the asynchronous nature of the web server is hidden from us where as it is certainly more apparent when building a web server with NodeJS.
​
## Setting up Rack
​
We can create a Gemfile in the root of our project and in here include the line:
​
```rb
source "https://rubygems.org"
​
gem "rack"
```
​
We can then run the command `bundle install` and start using the Rack library.
​
To set up the most basic Rack application, we'll need only 2 things: a `config.ru` file and an application class in a separate file.
​
## Request and response
​
Rack is an interface that servers a layer between any frameworks and the web server itself (the process actually listening for incoming requests from clients). The actions of the web server are abstracted away from us and the Rack library provides us with a much more intuitive interface for specifying what kind of response should be sent back to the client given some particular request. For example if the client makes a HTTP request with a `GET` method and to the path `/api/users` then we can use the Rack interface in order to respond to the client with the appropriate headers and response body.
​
## First application
​
A Ruby application is a Ruby object (and not the class itself) with a `call` method. The `call` method on this Ruby application will be invoked under the hood. It is in this `call` method where we can write logic in order to build a response to the client. A typical application looks as follows:
​
```rb
class Application
  def call(env)
    # write logic for the client response here
  end
end
```
​
The `call` method also has an `env` parameter: this is a hash with key-value pairs containing information about the incoming client request. We can inspect the env for information such as the request method and the path included in the client url. For example, if a client makes a `GET` request to the url with a path of `/api/users` the we can inspect these values on the hash, as below:
​
```rb
class Application
  def call(env)
    puts env["PATH_INFO"] # should log '/api/users'
    puts env["REQUEST_METHOD"] # should log 'GET'
  end
end
```
​
The call method must return an array with three elements:
​
- a status code,
- a hash representing the response headers
- a value representing the response body, usually in an array of strings
​
For example, we could have an application set up as follows:
​
```rb
class Application
  def call(env)
    [200,{},["Hello everyone"]]
  end
end
```
​
In the above example, the array `[200,{},["Hello everyone"]]` is implicitly returned from the `call` method and thus we are defining a response status code of `200`, no response headers and a response body including just a string of `"Hello everyone"`. It should be noted that the `"Hello everyone"` string is wrapped inside an array as Rack expects the third item in the array to have the `each` method available on it.
​
## Handling endpoints
​
When handling endpoints it can be as simple as using conditional logic with the `PATH_INFO` and `REQUEST_METHOD` properties.
​
```rb
# inside call method
  if env["PATH_INFO"] == '/home'
    [200, {}, ['Welcome to the home page']]
  end
```
​
By default if a url doesn't match any of your conditions, rack error out. This is easily fixed by adding an else clause.
​
## Routing
​
As your endpoints grow you'll want to start dividing up you logic using routing. The way to do this is to split up all the parts of your application into separate application classes, each with their own `call` method that takes `env`.
​
```rb
class DogApplication
  def call(env)
  end
end
​
class CatApplication
  def call(env)
  end
end
```
​
To route your programme to the correct application class you can specify a route in the `config.ru` file. Using the rack `map` method, it will send all requests who's PATH_INFO that match the provided string.
​
```rb
map('/dogs') do
  run DogApplication.new
end
​
map('/cats') do
  run CatApplication.new
end
```
​
`map` alters the `env` hash so that when the `call` method is invoked in either of these sub applications the `PATH_INFO` property is now anything that follows the original string passed to `map`. So in CatApplication to represent /cats/:id
​
```rb
# in CatApplication call method
  if env["PATH_INFO"] =~ %r{/\d+}
    # send back a single cat
  end
```
​
`map` Also comes with extra error handling functionality. If a url doesn't match any of the strings passed in to `map` if will send a 404 not found response.
​
## Rack requests
​
Any information as to the type of request coming in is found on the env `REQUEST_METHOD` property.
​
If its a request with information e.g. a post, the request body will be found using `rack.input`. This will be a Ruby I/O object, representing the body of the HTTP request.
​
Between this and checking all the methods and urls things get pretty messy.
​
Rack provides a `request` class to abstract this away.
​
```rb
request = Rack::Request.new(env)
​
request.path_info # "/id"
request.request_method # => request.post?
request.body # #<Rack::Lint::InputWrapper>
request.env # { ... full env hash ...}
```
​
`request.body` has a `read` method that returns the text that was submitted. Often since information comes as json we'll need to parse it : to do so you need to require in `json`.
​
```rb
# in call method
  if request.post?
    incoming_cat = json.parse(request.body.read)
    # add cat
    [201, {}, ['Cat added']]
```
​
## Rack responses
​
In the same way as the request class, rack provides a response class. It abstracts having to manually populate the array with a bunch of named setters.
​
```rb
response = Rack::Response.new # note you don't call with env!
​
response.status # =200
response.headers #  {} Set key/value pairs
response.body # []
response.finish # [200, {}, #<Rack::BodyProxy...>]
```
​
Rack response objects default to `status` of 200.
​
To set your own headers you can just add more key value pairs onto the .headers hash.
​
`response.finish` should go at the very end of your `call` method.
​
You may not want to write the entire body in an array at once, so there's also `response.write` method to incrementally add things onto the body - consider adding html:
​
```rb
response.write("<html>")
response.write("<body>")
response.write("</html>")
​
response.body # => [<html>...<body>...</html>]
```
​
It's preferable to set `Content-Length` and `Content-Type` headers:
​
- `response finish`: will calculate the length of the response and append this header automatically.
- to set content type just add it as a key on the headers hash
​
## Error handling
​
For 404s, if nothing is returned can use cat.nil?
​
For 400 where we might need to parse incoming data should use begin / rescue error handling syntax. For json.parse the Error class is `JSON::ParserError`
​
Hiding stack trace on unhandled exceptions for security reasons. If you run `rackup` with RACK_ENV=production - it will hide the stack with a stripped down error message
​
## Cleaning up and separating out
​
Separating controllers
​
using case statements
​
```rb
case request.path_info
when  request.post? && ""
 # post logic
```
​
Order matters in terms of precedence. With `.post?` or `.get?` first: the value of the string is th yield value of the condition to be matched against the case variable. The other way round, true is yielded to be matched against the case variable.
​
You can abstract reusable methods like `send_response_object` into a module which you can include into the top level application for the controllers to use.
​
## Middleware
​
All middlware must have `initialize` and `call` methods.
​
Initialize will accept and set the incoming app as an instance variable, so it can later on forward requests through the call method on the app that its wrapping.
​
```rb
class Middleware
  def initialize(app, opts={})
    @app = app
  end
  def call(env)
    @app.call(env) # currently this does nothing ...
  end
end
```
​
Once a middleware class is defined, you need to let Rack know you want to use middleware. Luckily rack provides a `use` method which we apply in the `config.ru` file
​
```rb
# in config.ru
​
use Middleware
​
# map calls to applications
```
​
You can have multiple usage of different middleware classes, but they will be stacked in order of when they are `use`d. The eventual response will then go backwards through the middleware back to the server.
​
Middleware classes can amend the incoming env variable by setting new keys onto it. There are fairly strict conventions to follow when setting your own keys so as to not overwrite anything else. This convention is normally `unique-key.property` e.g. `my-app.user_key`
​
Body replacements
​
If the body is replaced by a middleware after action, the original body must be closed first, if it responds to close
​
## Common middleware
​
- Not easy to have a view of what the overall middleware stack is, each one only know what is next
​
Can make a middleware `WhoIsCalling` to see the call stack that we've gone through to get here
​
```rb
class WhoIsCalling
  def initialize(app, opts={})
   @app = app
  end
​
  def call(env)
    puts caller.join("\n")
    @app.call(env)
  end
end
```
​
This shows some gems being put into play. If you are in production mode `RACK_ENV=production`. Some of them are stripped away.
​
### Useful middleware
​
- `Rack::Logger`
- `Rack::Reloader` : will reload any changes in your classes - each request will check the loaded ruby files and reload any that have been modified in the mean time. It picks up changes only in rb but not ru files - can pick up changes in your other classes. Reloading of ruby files can have side effects - e.g. reassigning any constants you deal with.
- `Rack::ContentType, "application/json"` - means you don't have to make repeated setting to content type in controllers.
- deflater, etag + conditionalget for optimized caching of not modified data
​
```rb
map('/docs') do
  run Rack::File.new('filepath') # for static files
end
```
​
## Resources
​
[Spec for rack](http://www.rubydoc.info/github/rack/rack/file/SPEC)
Collapse