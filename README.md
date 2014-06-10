# InsalesApi gem

[![Build Status](https://secure.travis-ci.org/insales/insales_api.png?branch=master)](http://travis-ci.org/insales/insales_api)

Insales api client based on [ActiveResource](https://github.com/rails/activeresource).

Rails application example is [here](https://github.com/insales/insales_app).

## Install

Add to Gemfile:

```ruby
gem 'insales_api'
```

## Initialize

```ruby
class MyApp < InsalesApi::App
  self.api_key = 'api_key'
end

MyApp.configure_api('domain', 'password')
```

## Use

```ruby
order = InsaleApi::Order.find 123

# singleton resources
account = InsaleApi::Account.find
```

### Handling Insales API request limit

There is a 500 requests per 5 minutes limit for Insales API. To handle this limitation gracefully, use `InsalesApi.wait_retry` method:
```ruby
# prepare a handler for request limit case
notify_user = Proc.new do |wait_for, attempt, max_attempts, ex|
  puts "API limit reached. Waiting for #{wait_for} seconds. Attempt #{attempt}/#{max_attempts}"
end

# perform 10 attempts to get products
InsalesApi.wait_retry(10, notify_user) do |x|
  puts "Attempt ##{x}."
  products = InsalesApi::Products.all
end
```

If you don't need to cap the attempts number or you don't want to do any special processing, simply drop the arguments:
```ruby
InsalesApi.wait_retry do
  products = InsalesApi::Products.all # will try to get products until the limit resets
end
```
