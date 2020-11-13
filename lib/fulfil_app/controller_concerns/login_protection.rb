# frozen_string_literal: true

module FulfilApp
  module LoginProtection
    extend ActiveSupport::Concern

    def activate_fulfil_session
      if session['fulfil.user_id'].nil?
        Rails.logger.debug('[FulfilApp::LoginProtection] Not authenticated. Redirecting...')
        redirect_to FulfilApp.configuration.login_url
        return
      end

      begin
        Rails.logger.debug('[FulfilApp::LoginProtection] Activating session...')
        yield
      rescue StandardError
        Rails.logger.debug('[FulfilApp::LoginProtection] Expired authorization...')
        reset_session
        redirect_to FulfilApp.configuration.login_url
      ensure
        Rails.logger.debug('[FulfilApp::LoginProtection] Clearing session...')
      end
    end
  end
end
