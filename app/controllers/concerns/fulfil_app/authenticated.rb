# frozen_string_literal: true

module FulfilApp
  module Authenticated
    extend ActiveSupport::Concern

    included do
      include FulfilApp::LoginProtection
      around_action :activate_fulfil_session
      rescue_from Fulfil::Client::NotAuthorizedError, with: :refresh_token
    end
  end
end
