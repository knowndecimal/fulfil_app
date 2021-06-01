Rails.application.routes.draw do
  mount FulfilApp::Engine => '/fulfil_app'

  resources :products, only: %i[index show]

  root to: redirect('/products')
end
