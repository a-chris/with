# With

**Emulating Elixir `with` statement in Ruby.**

This project demonstrates how to emulate the Elixir with statement in Ruby. The with statement in Elixir allows for a concise way to handle multiple operations that may fail, each returning either an :ok or :error tuple. This Ruby class With provides a similar capability, enabling sequential operations that can fail gracefully.

Also, with a salt of [happy_with](https://github.com/vic/happy_with) to simplify debugging and error handling.

```ruby
def get_sender
  [:ok, { sender: "sender" }]
end

def get_subject
  [:error, StandardError.new("No subject")]
end

steps, e = With.()
               .if_ok(:sender) { get_sender }
               .if_ok(:subject) { get_subject }
               .else { |steps, e| puts "Error: #{e}"; puts steps }
               .collect
```

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

    $ bundle add UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/with. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/with/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the With project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/with/blob/master/CODE_OF_CONDUCT.md).
