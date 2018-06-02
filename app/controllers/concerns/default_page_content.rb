module DefaultPageContent
  extend ActiveSupport::Concern

  # Called before any class or method in this module
  included do
    # Callback before any action is taken, to +set_page_defaults+
    before_action :set_page_defaults
  end

  # Sets the title for the current page
  #
  #
  def set_page_defaults
    # Global instance variable, defaults to:... if not set by page
    @page_title = 'AWH - HATMS'
  end
end