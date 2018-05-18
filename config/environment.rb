# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :mailgun

# SMTP settings for mailgun
ActionMailer::Base.mailgun_settings = {
    api_key: Rails.application.secrets.mailgun_api_key,
    domain: Rails.application.secrets.mailgun_domain,
}