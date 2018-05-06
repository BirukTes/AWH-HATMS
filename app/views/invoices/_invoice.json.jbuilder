json.extract! invoice, :id, :date, :dateDue, :paymentRecieved, :patient_id, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
