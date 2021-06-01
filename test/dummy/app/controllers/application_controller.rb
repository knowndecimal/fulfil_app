class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= begin
      client = Fulfil::Client.new(
        subdomain: session['fulfil.subdomain'],
        token: session['fulfil.token'],
        debug: true
      )

      user = Fulfil::Model
             .new(model_name: 'res.user', client: client)
             .find(id: session['fulfil.user_id'])

      OpenStruct.new(user)
    end
  end

  helper_method :current_user
end
