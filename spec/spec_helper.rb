# This file is copied to spec/ when you run 'rails generate rspec:install'
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'insales_api'

InsalesApi::App.api_key            = 'test'
InsalesApi::App.api_secret         = 'test'
InsalesApi::App.api_host           = 'myshop.insales.ru'
InsalesApi::App.api_autologin_path = 'session/autologin'

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec
end
