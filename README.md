# SE API

SE API is a ruby gem for interacting with the Stack Exchange API. It was designed with the [SE Realtime Fee](https://stackexchange.com) in mind (specifically interactions through [se-realtime](https://github.com/izwick-schachter/se-realtime)), and therefore it will only work with four route subsets:

- `/users/{ids}`
- `/posts/{ids}`
- `/questions/{ids}`
- `/answers/{ids}`

## Installation

While a version of this gem does exist in rubygems, it's recommended to use it from git. The master branch should always work. You can add it to your Gemfile with:

```ruby
gem 'se-api', git: 'https://github.com/izwick-schachter/se-api.git', branch: 'master'
```

And then execute:

    $ bundle

## Usage

First, initialize your client. You can omit the api key, but it's strongly recommended that you use one because it increases your request limit drastically. Also, any paramters that you pass on initialization will be passed with any request (but can be overridden later). It is recommended that you set the `site` this way.

```ruby
require 'se/api'

cli = SE::API::Client.new(ENV['APIKey'], site: 'stackoverflow')
```

Now that you've initialized the client, you can use the instance methods provided:

> Note: All the routes below pass `**params` directly to the API.

- `post(id, **params)`: Gets a post based on the ID passed.
- `posts(*ids, **params)`: Get posts based on either a semicolon delimited string of ids or an array of ids.
- `question(id, **params)`: Gets a question based on the ID passed.
- `questions(*ids, **params)`: Gets questions based on either a semicolon delimited string of ids or an array of ids.
- `answer(id, **params)`: Gets an answer based on the ID passed.
- `answers(*ids, **params)`: Gets answers based on either a semicolon delimited string of ids or an array of ids.
- `user(id, **params)`: Gets a user based on the ID passed.
- `users(*ids, **params)`: Gets users based on either a semicolon delimited string of ids or an array of ids.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/izwick-schachter/se-api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Se::Api project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/izwick-schachter/se-api/blob/master/CODE_OF_CONDUCT.md).
