# Testing with rack-test
​
To begin building integration tests to test our endpoints we’ll need to add some extra functionality to `rspec`: a gem called `rack-test`.
​
## Config Setup
​
Rack-test is easily configured into the `rspec` test suite by adding into our spec_helper file:
`config.include Rack::Test::Methods`
​
We’ll also need some additions to our `.rspec` file, namely the extra requirements of our test suite:
​
- `--require 'rack/test'`
- `--require 'app/my_first_app'`
- you’ll likely need to `json` too
​
## Writing your first test
​
As ever you have to follow the `AAA` format, so you’ll need to initialize and instance of your app to be testing. It would be easiest to place this is the outermost scoping of `describe` blocks
​
```rb
  let(:app){App.new }
```
​
> Note, now that we are not using the `config.ru` file anymore but directly calling our App - the implemented routing using `map` is lost! There are ways to make use of the full `config.ru` file but let’s use this as an opportunity to refactor in order to bring routing in-house
​
Once you’ve nested an extra context or describe block, lets say for an example route `/home` you can start making requests to your application.
Making a request from your test suite is simply calling a `request method` function and providing it a url path:
​
- `get '/birds'`
​
If you wish to provide extra information on your request you can add extra parameters e.g. adding a request body
​
```rb
post '/birds', JSON.generate({name: 'Tweetie'})
```
​
This method returns a `Rack::MockResponse` object with status, body, headers and other important properties that you can test for using simple `rspec` assertions.
This object is available either as `last_response` or if you use `let(:)` syntax you can rename it as you wish. Note `let` syntax is only available at `describe/ context` level
​
```rb
it #example test
  get '/birds'
  expect(last_response.status).to eq(200)
  expect(JSON.parse(last_response.body)).to eq({blah:blah})
```
​
## Resources
​
[Rack-test github](https://github.com/rack-test/rack-test)
[More rack docs](https://www.rubydoc.info/gems/rack/Rack)
Collapse
