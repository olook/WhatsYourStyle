# encoding: utf-8
require 'rubygems'
require 'bundler'
require 'ruby-debug'
require 'csv'

Bundler.require :default, :test

Goliath.env = 'test'

require 'pry'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'api'
require 'fixture_helper'


RSpec.configure do |config|
  
  config.mock_with :rspec
  config.include Rack::Test::Methods
  config.include JsonSpec::Helpers
  config.include WhatsYourStyle::FixtureHelper

  #config.extend  DatabaseCleanerHelpers

  config.before :suite do
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.strategy = :transaction
  end

  config.after :suite do
    DatabaseCleaner.clean
  end

end