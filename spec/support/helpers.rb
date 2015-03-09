RSpec.configure do |config|
  config.include FeatureHelpers
  config.include Rails.application.routes.url_helpers
end