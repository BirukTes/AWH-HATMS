class RenamePriceOnInvoiceDetail < ActiveRecord::Migration[5.1]
  def change
    rename_column :invoice_details, :price, :unitPrice
    add_column :invoice_details, :tax, :decimal, default: 0.00
  end
end
