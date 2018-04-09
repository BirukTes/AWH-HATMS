class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Import modules
  include DeviseWhiteList
  include DefaultPageContent

end
