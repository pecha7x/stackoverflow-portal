ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'rails/application'
require 'helper.rb'

Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  config.mock_with :rspec

  config.include Helper
  config.include FactoryGirl::Syntax::Methods

  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean_with :deletion
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end