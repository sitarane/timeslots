ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require 'minitest/autorun'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Setup capybara to work with the browser container
  Capybara.server_host = "0.0.0.0"
  Capybara.app_host = "http://#{ENV.fetch("HOSTNAME")}:#{Capybara.server_port}"

  # Add more helper methods to be used by all tests here...
  def log_in_as(user, password: 'password')
      post sessions_path, params: { email: user.email, password: password}
  end
end
