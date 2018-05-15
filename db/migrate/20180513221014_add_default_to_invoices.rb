class AddDefaultToInvoices < ActiveRecord::Migration[5.1]
  def change
    rename_column :invoices, :paymentRecieved, :paymentReceived
    change_column :invoices, :paymentReceived, :boolean, default: false
  end
end
