# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'simplecov'
SimpleCov.start

require 'insales_api'

InsalesApi::App.api_key           = 'test'
InsalesApi::App.api_secret        = 'test'
InsalesApi::App.api_autologin_url = 'https://host.com/session/autologin'

# simple eager load:
require 'insales'
Dir.glob('lib/**/*.rb').each { |file| require file.sub(/^lib\//, '') }

RSpec.configure do |config|
  config.mock_with :rspec
end
