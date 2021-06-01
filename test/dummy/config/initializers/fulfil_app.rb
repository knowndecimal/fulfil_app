puts 'Configuring FulfilApp'

FulfilApp.configure do |c|
  c.client_id = 'CLIENT_ID'
  c.client_secret = 'CLIENT_SECRET'
  c.login_url = '/fulfil_app/session/new'
end
