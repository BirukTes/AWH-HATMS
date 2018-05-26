# Preview all emails at http://localhost:3000/rails/mailers/invoice_mailer
class InvoiceMailerPreview < ActionMailer::Preview

  def new_unpaid
    # InvoiceMailer.unpaid_invoice_request(Admission.find(5).invoice)
    SendInvoiceEmailJob.perform_later(Admission.find(5).invoice)
  end

  def new_paid
    InvoiceMailer.delay.paid_invoice_confirmation(Admission.find(5).invoice)
  end
end
