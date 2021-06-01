# frozen_string_literal: true

module FulfilApp
  module LoginProtection
    extend ActiveSupport::Concern

    def activate_fulfil_session
      if session['fulfil.user_id'].nil?
        log('Not authenticated. Redirecting...')
        redirect_to FulfilApp.configuration.login_url
        return
      end

      log('Activating session...')
      yield
    ensure
      log('Clearing session...')
    end

    def log(message)
      Rails.logger.debug("[FulfilApp::LoginProtection] #{message}")
    end

    def refresh_token
      log('Expired authorization...')

      session['fulfil.token'] = nil
      session['fulfil.user_id'] = nil

      redirect_to session_refresh_path
    end
  end
end
