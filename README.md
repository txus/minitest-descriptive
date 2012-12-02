# minitest-descriptive

This little plug-in makes your assertion diffs much smarter about the way you
write your tests.

Let's say you have this failing test:

```ruby
class FooTest < MiniTest::Unit::TestCase
  def test_works
    @right = 1
    @wrong = 3
    assert_equal @right, 3
  end
end
```

Normally Minitest would output this:

```
1) Failure:
test_works(FooTest) [test_foo.rb:2]:
Expected: 1
  Actual: 3
```

This is a simple example, but `Expected: 1` doesn't give us much information.
What did 1 mean? And what is 3??? After 6 months, you've forgotten. But then you
look at the test, "oh, 1 was `@right` and 3 was `@wrong`! of course".

With `minitest-descriptive`, your output would be like this:

```
1) Failure:
test_works(FooTest) [test_foo.rb:2]:
Expected: 1 (@right)
  Actual: 3 (@wrong)
```

Much more descriptive, isn't it?

## Only instance variables? I want it to be smart about local variables too!

If you're running on [Rubinius][rubinius], `minitest-descriptive` automatically
tries to be smart about local variables too. So if we changed the test case to
use a local variable:

```ruby
class FooTest < MiniTest::Unit::TestCase
  def test_works
    @right = 1
    wrong = 3
    assert_equal @right, 3
  end
end
```

Your output would be like this:

```
1) Failure:
test_works(FooTest) [test_foo.rb:2]:
Expected: 1 (@right)
  Actual: 3 (wrong)
```

Cool eh? :)

## Installation

Add this line to your application's Gemfile:

    gem 'minitest-descriptive'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minitest-descriptive

And finally add this to your `test_helper.rb` file:

```ruby
require 'minitest-descriptive'

class MiniTest::Unit::TestCase
  include MiniTest::Descriptive
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[rubinius]: http://rubini.us

## Who's this

This was made by [Josep M. Bach (Txus)](http://txustice.me) under the MIT
license. I'm [@txustice](http://twitter.com/txustice) on twitter (where you
should probably follow me!).
