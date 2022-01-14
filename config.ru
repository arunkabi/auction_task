# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
Rails.application.load_server

begin
  require 'minitest/autorun'
rescue LoadError => e
  raise e unless ENV['RAILS_ENV'] == "production"
end