# coding: utf-8
unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_group 'GemTemplate', 'lib/gem_template'
    add_group 'Specs', 'spec'
  end
end

require 'coveralls'
Coveralls.wear!

require 'omniauth-tradier'

require 'rspec'
require 'rack/test'
require 'webmock/rspec'

WebMock.disable_net_connect!(:allow => 'coveralls.io')

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include WebMock::API
  config.include Rack::Test::Methods
  config.extend  OmniAuth::Test::StrategyMacros, :type => :strategy
end
