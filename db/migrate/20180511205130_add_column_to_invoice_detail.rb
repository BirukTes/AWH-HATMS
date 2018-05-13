class AddColumnToInvoiceDetail < ActiveRecord::Migration[5.1]
  def change
    add_column :invoice_details, :lineTotal, :decimal, precision: 15, scale: 2
  end
end
