json.extract! invoice, :id, :date, :dateDue, :paymentReceived, :patient_id, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
