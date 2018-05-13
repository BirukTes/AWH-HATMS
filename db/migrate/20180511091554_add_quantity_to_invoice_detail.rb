class AddQuantityToInvoiceDetail < ActiveRecord::Migration[5.1]
  def change
    add_column :invoice_details, :quantity, :integer
  end
end
