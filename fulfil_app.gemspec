# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'fulfil_app/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'fulfil_app'
  spec.version     = FulfilApp::VERSION
  spec.authors     = ['Chris Moore']
  spec.email       = ['chris@knowndecimal.com']
  spec.homepage    = 'https://github.com/knowndecimal/fulfil_app'
  spec.summary     = 'Quickly incorporate Fulfil API and sessions in to your Rails app.'
  spec.description = 'Description of FulfilApp.'
  spec.license     = 'MIT'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'fulfil-io'
  spec.add_dependency 'oauth2'
  spec.add_dependency 'rails', '~> 6.1.3', '>= 6.0.3.4'

  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'sqlite3'
end
