# coding: utf-8
unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_group 'GemTemplate', 'lib/gem_template'
    add_group 'Specs', 'spec'
  end
end

require 'rspec'
require 'rack/test'
require 'webmock/rspec'
require 'omniauth-tradier'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include WebMock::API
  config.include Rack::Test::Methods
  config.extend  OmniAuth::Test::StrategyMacros, :type => :strategy
end
