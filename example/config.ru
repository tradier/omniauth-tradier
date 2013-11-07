require 'bundler/setup'
require 'sinatra/base'
require 'omniauth-tradier'
require 'multi_json'

SCOPE = %w(read write trade).join(',')

class App < Sinatra::Base
  get '/' do
    redirect '/auth/tradier'
  end

  get '/auth/:provider/callback' do
    content_type 'application/json'
    MultiJson.encode(request.env)
  end

  get '/auth/failure' do
    content_type 'application/json'
    MultiJson.encode(request.env)
  end
end

use Rack::Session::Cookie, :secret => 'sikrit'

use OmniAuth::Builder do
  provider :tradier, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], :scope => SCOPE
end

run App.new
