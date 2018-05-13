class AddReferencesToInvoice < ActiveRecord::Migration[5.1]
  def change
    add_reference :invoices, :admission, foreign_key: true
  end
end
