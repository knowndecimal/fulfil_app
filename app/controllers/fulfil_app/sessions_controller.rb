# frozen_string_literal: true

require 'securerandom'

class FulfilApp::SessionsController < ApplicationController
  before_action :verify_nonce!, only: :callback
  before_action :redirect_if_authenticated!, only: :new

  layout 'fulfil_app/sessions'

  def create
    session[:nonce] = SecureRandom.hex
    session['fulfil.subdomain'] = params[:subdomain]

    auth_url = FulfilApp::Session.authorize_url(
      host: "#{request.protocol}#{request.host_with_port}",
      nonce: session[:nonce],
      subdomain: session['fulfil.subdomain']
    )

    log('Redirecting to Fulfil for auth...')
    redirect_to auth_url
  end

  def refresh
    render :create
  end

  def callback
    log('Authenticating...')
    token = FulfilApp::Session.get_token(code: params[:code], subdomain: session['fulfil.subdomain'])

    user_info = token.params['associated_user']
    log("Authenticated #{session['fulfil.subdomain']} as #{user_info}...")
    session['fulfil.user_id'] = user_info['id']
    session['fulfil.token'] = token.token

    session[:nonce] = nil

    redirect_to '/'
  end

  def destroy
    session['fulfil.subdomain'] = nil
    session['fulfil.token'] = nil
    session['fulfil.user_id'] = nil

    reset_session
    redirect_to new_session_path
  end

  private

  def login_path
    FulfilApp.configuration.login_url
  end

  def verify_nonce!
    return if session[:nonce] == params[:state]

    log('nonce did not match...')
    redirect_to login_path and return
  end

  def verified?
    session['fulfil.user_id'].present? && session['fulfil.token'].present?
  end

  def redirect_if_authenticated!
    redirect_to '/' and return if verified?
  end

  def log(message)
    Rails.logger.debug("[FulfilApp::SessionsController] #{message}")
  end
end
