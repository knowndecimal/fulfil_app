# frozen_string_literal: true

FulfilApp::Engine.routes.draw do
  resource :session, only: %i[new create destroy]

  get '/session/refresh', to: 'sessions#create'
  get '/oauth2/callback', to: 'sessions#callback'
end
