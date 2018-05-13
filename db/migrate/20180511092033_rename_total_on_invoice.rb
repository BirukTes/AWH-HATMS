class RenameTotalOnInvoice < ActiveRecord::Migration[5.1]
  def change
    rename_column :invoices, :total, :amount
  end
end
