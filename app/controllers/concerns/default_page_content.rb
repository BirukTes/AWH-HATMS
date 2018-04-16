module DefaultPageContent
  extend ActiveSupport::Concern

  included do
    before_action :set_page_defaults
  end

  def set_page_defaults
    @page_title = 'AWH - HATMS'
    # @seo_keywords = 'AWH Login'
  end
end