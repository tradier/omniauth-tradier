# OmniAuth Tradier

[![Gem Version](https://badge.fury.io/rb/omniauth-tradier.png)][gem]
[![Build Status](https://secure.travis-ci.org/tradier/omniauth-tradier.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/tradier/omniauth-tradier.png)][gemnasium]
[![Coverage Status](https://coveralls.io/repos/tradier/omniauth-tradier/badge.png?branch=master)][coveralls]

[gem]: https://rubygems.org/gems/omniauth-tradier
[travis]: http://travis-ci.org/tradier/omniauth-tradier
[gemnasium]: https://gemnasium.com/tradier/omniauth-tradier
[coveralls]: https://coveralls.io/r/tradier/omniauth-tradier

This is the official OmniAuth strategy for authenticating with Tradier's API. To
use it, you'll need a Client ID and Secret which can be obtained from [developer.tradier.com](https://developer.tradier.com/).

## Usage

Add the strategy to your `Gemfile`:

```ruby
gem 'omniauth-tradier'
```

Then integrate the strategy into your middleware:

```ruby
use OmniAuth::Builder do
  provider :tradier, ENV['CLIENT_ID'], ENV['SECRET']
end
```

In Rails, you'll want to add to the middleware stack:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tradier, ENV['CLIENT_ID'], ENV['SECRET']
end
```

### Scopes

Tradier's API lets you set scopes to provide granular access to different types of data:

```ruby
use OmniAuth::Builder do
  provider :tradier, ENV['CLIENT_ID'], ENV['SECRET'], :scope => "read,write,trade"
end
```

For more information on available scopes, refer to Tradier's [API documentation][scope].

[scope]: http://developer.tradier.com/documentation/overview/registration

## Copyright

Copyright (c) 2013 Tradier Inc. See [LICENSE](LICENSE.md) for details.
