class ProductsController < ApplicationController
  include FulfilApp::Authenticated

  def index
    @products = Fulfil::Model
                .new(model_name: 'product.product', client: client)
                .search(domain: [['active', '=', true]], limit: 50)
  end

  def show
    @product = Fulfil::Model
               .new(model_name: 'product.product', client: client)
               .find(id: params[:id])
  end

  private

  def client
    @client ||= Fulfil::Client.new(
      subdomain: session['fulfil.subdomain'],
      token: session['fulfil.token'],
      debug: true
    )
  end
end
