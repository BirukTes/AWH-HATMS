class RenameColumnToInvoices < ActiveRecord::Migration[5.1]
  def change
    rename_column :invoices, :date, :dateReceived
  end
end
