require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AWHHatms
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Set the queue_adapter
    config.active_job.queue_adapter = :delayed_job

    # This needs to be done in a to_prepare callback because it's executed
    # once in production and before each request in development.
    config.to_prepare do
      # Configure single controller layout
      Devise::SessionsController.layout('login')
      Devise::PasswordsController.layout('login')
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
