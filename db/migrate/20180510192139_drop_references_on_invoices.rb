class DropReferencesOnInvoices < ActiveRecord::Migration[5.1]
  def change
    remove_reference :invoices, :patient, foreign_key: true
  end
end
