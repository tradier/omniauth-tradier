require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Tradier < OmniAuth::Strategies::OAuth2

      DEFAULT_SCOPE = 'read,write,market,trade,stream'

      option :client_options, {
        :site          => 'https://api.tradier.com',
        :authorize_url => 'https://api.tradier.com/v1/oauth/authorize',
        :token_url     => 'https://api.tradier.com/v1/oauth/accesstoken'
      }

      def authorize_params
        super.tap do |params|
          [:scope].each do |v|
            params[v] = request.params[v] if request.params[v]
          end

          params[:scope] ||= DEFAULT_SCOPE
        end
      end

      uid { raw_info['profile']['id'] }

      info do
        {
          'name' => raw_info['profile']['name']
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def raw_info
        @raw_info ||= access_token.get('/v1/user/profile', :headers => { 'Accept' => 'application/json' }).parsed
      end

    end
  end
end

OmniAuth.config.add_camelization 'tradier', 'Tradier'
