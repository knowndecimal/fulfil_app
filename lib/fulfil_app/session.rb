# frozen_string_literal: true

require 'oauth2'

module FulfilApp
  class Session
    class << self
      def client(subdomain:)
        @client ||= OAuth2::Client.new(
          FulfilApp.configuration.client_id,
          FulfilApp.configuration.client_secret,
          site: client_url(subdomain: subdomain),
          logger: Rails.logger
        )
      end

      def authorize_url(host:, nonce:, subdomain:)
        client(subdomain: subdomain).auth_code.authorize_url(
          redirect_uri: "#{host}/fulfil_app/oauth2/callback",
          state: nonce,
          scope: 'user_session'
        )
      end

      def get_token(code:, subdomain:)
        client(subdomain: subdomain).auth_code.get_token(code)
      end

      private

      def client_url(subdomain:)
        "https://#{subdomain}.fulfil.io"
      end
    end
  end
end
