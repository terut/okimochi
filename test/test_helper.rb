ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryGirl::Syntax::Methods

  # https://github.com/amatsuda/database_rewinder#mysql--use_transactional_tests-specific-problems
  self.use_transactional_tests = false
end

module DatabaseCleanUp
  def self.prepare
    # Add code that needs to be executed before test suite start
    DatabaseRewinder.clean_all
  end
  prepare

  def setup
    # Add code that need to be executed before each test
  end

  def teardown
    # Add code that need to be executed after each test
    DatabaseRewinder.clean
  end
end

ActiveSupport::TestCase.send :prepend, DatabaseCleanUp
