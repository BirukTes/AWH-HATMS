class GeneratePdfInvoiceJob < Struct.new(:invoice_id)
  # queue_as :default

  # delayed_job automatically looks for a "perform" method
  def perform(*args)
    ActionView::Base.send(:define_method, :protect_against_forgery?) { false }
    # create an instance of ActionView, so we can use the render method outside of a controller
    av = ActionView::Base.new

    av.view_paths = ActionController::Base.view_paths

    # need these in case your view constructs any links or references any helper methods.
    av.class_eval do
      include Rails.application.routes.url_helpers
      include ApplicationHelper
    end

    pdf_html = av.render(:template => "invoices/show.pdf.erb", :layout => 'layouts/pdf.html.erb', locals: { :invoice => invoice })

    Rails.logger.info '*' * 50
    Rails.logger.info  pdf_html.inspect
    Rails.logger.info  '*' * 50

    # use wicked_pdf gem to create PDF from the doc HTML
    invoice_pdf = WickedPdf.new.pdf_from_string(pdf_html, :page_size => 'Letter')

    # save PDF to disk
    pdf_path = Rails.root.join('tmp', "#{invoice.id}.pdf")
    File.open(pdf_path, 'wb') do |file|
      file << invoice_pdf
    end
  end

  # delayed_job's built-in success callback method
  def success(job)
    # invoice.update_attribute(:status, 'complete')

  end

  private

  # get the invoice object when the job is run
  def invoice
    @invoice = Invoice.find(invoice_id)
  end
end
