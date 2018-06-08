# Provides  functionality to controllers all as a parent,
# Runs code with high priority, here such as Auth
#
# @author Bereketab Gulai
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Import modules
  include DeviseWhitelist
  include DefaultPageContent
  include Pundit

  # All controllers must be authenticated, a callback
  before_action(:authenticate_staff!)


  # Authorisation callback, to check the action requested performs authorisation
  # Runs all requests unless (if not) devise controller
  after_action(:verify_authorized, unless: :devise_controller?)

  # Define the method pundit should use to find current u
  def pundit_user
    current_staff
  end

  # This defines the responses types, or It is referencing the response that will
  # be sent to the View (which is going to the browser) https://stackoverflow.com/a/9492463/5124710
  # These all the formats used in this application, defined globally
  respond_to(:html, :json, :js, :xlsx)

  def respond_modal_with(*args, &blk)
    options = args.extract_options!
    options[:responder] = ModalResponder
    respond_with(*args, options, &blk)
  end


  # Authorisation error handling
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end
end
