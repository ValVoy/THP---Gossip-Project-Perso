ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    parallelize(workers: :number_of_processors)

    # Ajoute cette méthode pour simuler une connexion dans les tests d'intégration
    def log_in_as(user)
      post sessions_path, params: { email: user.email, password: "password" }
    end
  end
end
