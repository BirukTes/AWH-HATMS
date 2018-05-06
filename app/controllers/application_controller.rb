class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Import modules
  include DeviseWhitelist
  include DefaultPageContent
  include Pundit

  # All controllers must be authenticated, a callback
  before_action(:authenticate_staff!)


  def respond_modal_with(*args, &blk)
    options = args.extract_options!
    options[:responder] = ModalResponder
    respond_with *args, options, &blk
  end

  # Define the method pundit should use to find current u
  def pundit_user
    current_staff
  end

  # Authorisation error handling
  rescue_from Pundit::NotAuthorizedError do
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end
end
