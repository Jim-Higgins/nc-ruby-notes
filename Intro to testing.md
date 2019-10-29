# Intro to testing
## BDD + TDD, and Testing in Ruby
Ruby has some native testing suites e.g. `minitest` but they're quite minimal and often have wrappers around them to extend functionality . Other libraries are more extended (`Rspec`, `cucumber` etc)
We'll be using `BDD` + `TDD` throughout this course. Some major focus points when approaching `TDD` / `BDD`
- Small tests: make incremental increases in logic
- Red --> green --> refactor
  - see it fail first, solve, then refactor
Guide your tests with `AAA`:
- `Arrange` --> set up objects, reseed data etc...
- `Act` --> run the behavior you are testing
- `Assert` --> write your expectations based on that action
## Rspec
`Rspec` is one of main testing frameworks in Ruby community
`Rspec` can be used alone or in conjunction with other libraries like `cucumber` and `minitest`.
`Rspec` allows for TDD + BDD assertions and mocks.
`Rspec` has great documentation, it's just split up into separate sections as the library is split into separate gems:
- [Rspec-core latest version](https://Rspec.info/documentation/3.9/Rspec-core/)
- [Rspec-expectations latest version](https://Rspec.info/documentation/3.9/Rspec-expectations/)
- [Rspec-mocks latest version](https://Rspec.info/documentation/3.9/Rspec-mocks/)
### Setup
1. Install `Rspec` using your Gemfile or manually in the command line.
2. Make it so you can run `Rspec` for your local project with the command line through bundler using `bundle exec rspec`
> Running `rspec` now will automatically look for files in a spec directory with the name `*_spec.rb`.
At this stage you are ready to run tests. BUT there is one extra step to make testing a bit more helpful
3. Initialize `Rspec` local settings using `rspec init`. This creates 2 files: `.rspec`and `spec_helper` .
- `.rspec`: This contains settings for `Rspec` command line implementation. E.g. has `--colour` to personalize it. One you may want to use is the format output using`--format documentation` which gives more verbose feedback. This file also requires`spec_helper`
- `spec_helper`: This allows you to configure and enhance `Rspec` with additional functionality (NB: find some time to read through the comments in this file!). One useful piece of functionality is `focus` which allows you to run single tests at a time --> `config.filter_run_when_matching :focus`.
To make use of any of these extras you need to
a) uncomment the code and
b) require the `spec_helper` into your `.rspec` file using `--require spec_helper`
To run a single test using `focus` you would pass it in before your block starts
```rb
 it 'exists', :focus => true do
```
### Writing your first test
Like other testing libraries you've used, `rpsec` makes use of `describe` and `it` blocks
> For your first test, try doing a sanity check just based on booleans.
---
RSpec uses describe to organise and group tests: Use `describe` to nest describing the `behaviour` of something
`describe` has an alias `context` which you can use if you want to nest/group tests based on similar contextual factors e.g. `when provided no arguments...`
By default `describe` needs to be accessed off of the `RSpec` class --> `RSpec.describe ''`. But you can provide some configuration options in your `spec-helper` to make it a globally available variable: `expose_dsl_globally = true`
> make your `assertion`: have a look at the `Rspec-expectations` documentation and some of the previous tests you've used to guide you.
### When you get to testing your own methods:
- define your method and `require` it in using `require_relative './file_path` or `require 'base_filename` which will automatically look in the lib folder
- `act` by invoking your method
## Extra features
You Can also provide tags to skip or run specific tests [here for more](https://relishapp.com/Rspec/Rspec-core/v/2-12/docs/command-line/tag-option)
- `hooks`: functional hooks available e.g. `before` : particularly useful in conjunction with `context` grouping as you can `Arrange` tests in a common way e.g.
```rb
describe 'ExampleClass'
  context `when given no arguments` do
    before
    @test_variable = ExampleClass.new()
  # have to use @ instance variable to allow its access to this
    end
    it 'exists' do
      expect(@test_variable).not_to eq(nil)
    end
  end
end
```
Alternative way to the above so you don't keep relying on `@` instance variables - `let` uses [lazy evaluation](https://relishapp.com/rspec/rspec-core/docs/helper-methods/let-and-let) and is a specific Rspec helper method.
```rb
context `when given no arguments` do
  let(:test_variable) {ExampleClass.new()}
  it 'exists' do
    expect(:test_variable).not_to eq(nil)
  end
end
```