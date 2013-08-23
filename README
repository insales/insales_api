# InsalesApi gem

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
