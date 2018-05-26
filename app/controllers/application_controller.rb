# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # layout('login') if controller_name.eql?('sessions')

  # Import modules
  include DeviseWhitelist
  include DefaultPageContent
  include Pundit

  # All controllers must be authenticated, a callback
  before_action(:authenticate_staff!)

  # This defines the responses types, or It is referencing the response that will
  # be sent to the View (which is going to the browser) https://stackoverflow.com/a/9492463/5124710
  respond_to(:html, :json, :js)

  def respond_modal_with(*args, &blk)
    options = args.extract_options!
    options[:responder] = ModalResponder
    respond_with(*args, options, &blk)
  end

  # Define the method pundit should use to find current u
  def pundit_user
    current_staff
  end

  # Authorisation error handling
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end
end
