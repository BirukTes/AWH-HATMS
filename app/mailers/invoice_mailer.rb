# Sends unpaid and paid invoices attaching PDF
#
# @author Bereketab Gulai
class InvoiceMailer < ApplicationMailer

  # Sends the unpaid invoice to the patient
  #
  # @param (invoice) - the invoice to send
  def unpaid_invoice_request(invoice)
    begin
      @invoice = invoice
      @patient = @invoice.admission.patient

      # Generate the PDF Invoice
      generate_pdf_invoice('invoices/_unpaid_invoice_template.html.erb', 'unpaid_invoice')

      # Debug using Mailgun::Client.new(Rails.application.secrets.mailgun_api_key, "bin.mailgun.net", "b913673b", ssl = false)
      mg_client = Mailgun::Client.new(Rails.application.secrets.mailgun_api_key)

      result = mg_client.send_message(Rails.application.secrets.mailgun_domain, unpaid_invoice_message).to_h!
      result_message = result['message']

      puts(result_message)
    rescue => e
      Rails.logger.error { "#{e.message} #{e.backtrace.join("\n")}" }
      Rollbar.report_exception(e)
      puts 'Exception: mail gun unpaid'
    end
  end

  # Sends the paid invoice to the patient
  #
  # @param (invoice) - the invoice to send
  def paid_invoice_confirmation(invoice)
    begin
      @invoice = invoice
      @patient = @invoice.admission.patient

      # Generate the PDF Invoice
      generate_pdf_invoice('invoices/_paid_invoice_template.html.erb', 'paid_invoice')

      # Debug using Mailgun::Client.new(Rails.application.secrets.mailgun_api_key, "bin.mailgun.net", "b913673b", ssl = false)
      mg_client = Mailgun::Client.new(Rails.application.secrets.mailgun_api_key)

      result = mg_client.send_message(Rails.application.secrets.mailgun_domain, paid_invoice_message).to_h!
      result_message = result['message']

      puts(result_message)
    rescue StandardError => e
      Rails.logger.error { "#{e.message} #{e.backtrace.join("\n")}" }
      Rollbar.report_exception(e)
      puts 'Exception: mail gun paid'
    end
  end


  private

  # Creates a massage for the unpaid invoice
  def unpaid_invoice_message
    data = {}
    data[:from] = Rails.application.secrets.mail_from
    # Sandbox as of now only allows to verified recipients,
    # once a domain is found then the, change to +@invoice.admission.patient.email+
    data[:to] = 'allswell.hospital@outlook.com'
    data[:subject] = 'Your AllsWell Hospital Invoice'
    data[:text] = 'Please find the PDF invoice attached.'
    data[:html] = "#{render('invoice_mailer/unpaid_invoice_request', invoice: @invoice)}"
    data[:attachment] = []
    data[:attachment] << File.new(File.join("tmp", "unpaid_invoice#{@invoice.id}.pdf"))
    # Attach the image logo
    data[:inline] = File.new(File.join("app/assets/images", "awh_logo_170x92.png"))
    data
  end

  # Creates a massage for the paid invoice
  def paid_invoice_message
    data = {}
    data[:from] = Rails.application.secrets.mail_from
    data[:to] = 'allswell.hospital@outlook.com'
    data[:subject] = 'Your Invoice Confirmation'
    data[:text] = 'Please find the PDF confirmation of your invoice payment attached.'
    data[:html] = "#{render('invoice_mailer/paid_invoice_confirmation', invoice: @invoice)}"
    data[:attachment] = []
    data[:attachment] << File.new(File.join("tmp", "paid_invoice#{@invoice.id}.pdf"))
    data
  end

  # Generates a PDF for given invoice template
  #
  # @param (template) - the template that will be used to generate (paid/unpaid)
  # @param (invoice_name) - the name of the file (paid/unpaid)
  def generate_pdf_invoice(template, invoice_name)
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

    # Render the template and store to variable
    pdf_html = av.render(template: template, layout: 'layouts/pdf.html.erb', locals: { invoice: @invoice })

    # use wicked_pdf gem to create PDF from the doc HTML
    invoice_pdf = WickedPdf.new.pdf_from_string(pdf_html, page_size: 'Letter')

    # save PDF to disk
    pdf_path = Rails.root.join('tmp', invoice_name + "#{@invoice.id}.pdf")
    File.open(pdf_path, 'wb') do |file|
      file << invoice_pdf
    end
  end
end