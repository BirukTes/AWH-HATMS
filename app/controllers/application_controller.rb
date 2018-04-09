class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Import modules
  include DeviseWhitelist
  include DefaultPageContent
end
