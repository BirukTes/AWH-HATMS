class InvoiceMailer < ApplicationMailer

  def send_invoice(patient)
    @patient = patient

    # binding.pry
    # Mailgun::Client.new(Rails.application.secrets.mailgun_api_key, "bin.mailgun.net", "b913673b", ssl = false)
    mg_client = Mailgun::Client.new(Rails.application.secrets.mailgun_api_key)

    message_params = {
        from: Rails.application.secrets.mail_from,
        to: @patient.email,
        subject: 'The Ruby SDK is awesome!',
        text: 'It is really easy to send a message!'
    }

    result = mg_client.send_message(Rails.application.secrets.mailgun_domain, message_params).to_h!
    message_id = result['id']
    message = result['message']
    puts(message)
  end

end
