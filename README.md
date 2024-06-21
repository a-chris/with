# With

**Emulating Elixir `with` statement in Ruby.**

Sponsored by [ACME Corp](https://acmecorp.dev). Already running in production on [DiscoRocks](https://disco.rocks) and [Coney.app](https://coney.app).

This is an opinionated way to emulate the Elixir `with` statement in Ruby. The with statement in Elixir allows for a concise way to handle multiple operations that may fail, each returning either an `:ok` or `:error` tuple. This Ruby class With provides a similar capability, enabling sequential operations that can fail gracefully.

Also, with a salt of [happy_with](https://github.com/vic/happy_with) to simplify debugging and error handling.

**Sequential Operations with if_ok:**
The if_ok method takes a key and a block. It executes the block only if the previous steps were successful and collect the result in a Hash with the provided key.
The block should return a tuple in the form of `[:ok, value]` or `[:error, anything]`.
Depending on the result, it updates the internal state to continue or halt further operations.

**Error Handling with else:**
The else method is called if any step in the sequence fails.
It yields the accumulated steps and the error to a provided block for handling.

**Result Collection with collect:**
The collect method returns the accumulated steps and the error, if any.

**Easier debugging experience:**
The `steps` Hash collect each result in the given key, so you can easily inspect the results of each step and indentify where the error occurred.

## Example

This example demonstrates the use of the `With` class to manage a sequence of operations, ensuring that each step is only executed if the previous one succeeded. If any step fails, the process halts and an error handler is invoked.

```ruby
def get_sender
  [:ok, { sender: "sender" }]
end

def get_subject(sender_value)
  [:error, StandardError.new("No subject")]
end

def unreachable_method
  [:ok, "unreachable"]
end

steps, e = With.()
               .if_ok(:sender) { get_sender }
               .if_ok(:subject) { |steps| get_subject(steps[:sender]) }
               .if_ok(:unreachable) { unreachable_method }
               .else { |steps, e| puts "Error: #{e}"; puts steps }
               .collect
```

In this case:
1. `get_sender` is called and the result is stored in the steps Hash with the key **:sender**.
2. `get_subject` is called with the result of get_sender and the result is stored in the steps Hash with the key **:subject**.
3. unreachable will not be called because `get_subject` failed with **[:error, anything]**
4. The else block will be called with the steps Hash and the error
5. Finally, the `collect` method will return the steps hash and the error

This is the same of running several nested case matching statements:

```ruby
case get_sender
in :ok, sender
  case get_subject(sender)
  in :ok, subject
    case unreachable_method
    in :ok, value
      puts "Subject: #{subject}"
    in :error, e
      puts "Error: #{e}"
    end
  in :error, e
    puts "Error: #{e}"
  end
in :error, e
  puts "Error: #{e}"
end
```


## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add with

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install with

## Usage

TODO

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/with. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/with/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the With project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/with/blob/master/CODE_OF_CONDUCT.md).
