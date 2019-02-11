require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

module RequestHelpers
  def as(role, **opts)
    user = role.is_a?(User) ? role : create(role, **opts)
    sign_in(user)
    user
  end

  def json
    return if response.body.empty?
    Hashie::Mash.new JSON.parse response.body
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods
  config.include RequestHelpers, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :request
end
