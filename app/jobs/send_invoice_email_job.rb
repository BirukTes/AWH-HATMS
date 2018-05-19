# frozen_string_literal: true

class SendInvoiceEmailJob < ApplicationJob
  queue_as :default

  def perform(admission, *_args)
    # enqueue our custom job object that uses delayed_job methods
    ActionView::Base.send(:define_method, :protect_against_forgery?) { false }
    # create an instance of ActionView, so we can use the render method outside of a controller
    av = ActionView::Base.new

    av.view_paths = ActionController::Base.view_paths

    # need these in case your view constructs any links or references any helper methods.
    av.class_eval do
      include Rails.application.routes.url_helpers
      include ApplicationHelper
    end

    pdf_html = av.render(template: 'invoices/show.pdf.erb', layout: 'layouts/pdf.html.erb', locals: { invoice: invoice })

    # use wicked_pdf gem to create PDF from the doc HTML
    invoice_pdf = WickedPdf.new.pdf_from_string(pdf_html, page_size: 'Letter')


    InvoiceMailer.send_invoice(admission.patient, invoice_pdf)
  end
end
