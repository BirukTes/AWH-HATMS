class InvoiceMailer < ApplicationMailer

  def send_invoice(invoice)
    @invoice = invoice
    @patient = @invoice.admission.patient

    # binding.pry
    # Mailgun::Client.new(Rails.application.secrets.mailgun_api_key, "bin.mailgun.net", "b913673b", ssl = false)
    mg_client = Mailgun::Client.new(Rails.application.secrets.mailgun_api_key)

    result = mg_client.send_message(Rails.application.secrets.mailgun_domain, message).to_h!
    message_id = result['id']
    result_message = result['message']

    puts(result_message)
  end

  def message
    data = {}
    data[:from] = Rails.application.secrets.mail_from
    data[:to] = 'biruktes@outlook.com'
    data[:subject] = 'Your AllsWell Hospital Invoice'
    data[:text] = 'Please find PDF invoice attached.'
    data[:html] = "#{render('invoice_mailer/send_invoice', invoice: @invoice)}"
    data[:attachment] = []
    data[:attachment] << File.new(File.join("tmp", "invoice_no#{@invoice.id}.pdf"))
    data
  end
end