class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Import modules
  include DeviseWhitelist
  include DefaultPageContent

  # All controllers must be authenticated
  before_action(:authenticate_staff!)


  def respond_modal_with(*args, &blk)
    options = args.extract_options!
    options[:responder] = ModalResponder
    respond_with *args, options, &blk
  end
end
