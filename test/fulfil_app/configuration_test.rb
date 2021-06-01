require 'test_helper'

class ConfigurationTest < ActiveSupport::TestCase
  setup do
    FulfilApp.configuration = nil
  end

  test 'configure' do
    FulfilApp.configure do |config|
      config.subdomain = 'test'
      config.client_id = '1234'
      config.client_secret = '4321'
    end

    assert_equal 'test', FulfilApp.configuration.subdomain
    assert_equal '1234', FulfilApp.configuration.client_id
    assert_equal '4321', FulfilApp.configuration.client_secret
  end
end
