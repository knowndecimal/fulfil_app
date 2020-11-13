# frozen_string_literal: true

module FulfilApp
  class Configuration
    attr_accessor :subdomain
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :login_url
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end
end
