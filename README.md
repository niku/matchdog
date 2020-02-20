# Matchdog

Matchdog is:

- a kind of expelimental library to make sure how much useful pattern maching in the wild
- dispaching HTTP reequest on the rack with using pattern maching

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'matchdog'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install matchdog

## Usage

Write `config.ru`.

```ruby
# config.ru
require "matchdog"

class App
  # When you declare
  using Matchdog
  def call(env)
    # You can apply pattern maching for HTTP request on the rack
    case env
      in {REQUEST_METHOD: "GET", PATH_INFO: "/"}  # matches GET '/'
      [200, {}, ["This is the root directory."]]
      in {REQUEST_METHOD: "GET", PATH_INFO: path} # macthes GET without '/' and set path data in the request to `path` variable
      [200, {}, [path]]
      in {REQUEST_METHOD: "POST", "rack.input": input} # matches POST and set post data in the request to `input` variable
      [200, {}, [input.read]]
    end
  end
end

run App.new
```

Run `ruckup` command to start HTTP server.

```bash
❯ bundle exec rackup
/Users/niku/src/matchdog/config.ru:8: warning: Pattern matching is experimental, and the behavior may change in future versions of Ruby!
[2020-02-21 09:07:30] INFO  WEBrick 1.6.0
[2020-02-21 09:07:30] INFO  ruby 2.7.0 (2019-12-25) [x86_64-darwin18]
[2020-02-21 09:07:30] INFO  WEBrick::HTTPServer#start: pid=65361 port=9292
```

Test HTTP request and response

```irb
❯ bundle exec irb
irb(main):001:0> require "net/http"
=> true
irb(main):002:0> Net::HTTP.get(URI.parse("http://localhost:9292"))
=> "This is the root directory."
irb(main):003:0> Net::HTTP.get(URI.parse("http://localhost:9292/hello"))
=> "/hello"
irb(main):004:0> Net::HTTP.post(URI.parse("http://localhost:9292"), "You will receive this message").read_body
=> "You will receive this message"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/niku/matchdog. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/niku/matchdog/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Matchdog project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/niku/matchdog/blob/master/CODE_OF_CONDUCT.md).
