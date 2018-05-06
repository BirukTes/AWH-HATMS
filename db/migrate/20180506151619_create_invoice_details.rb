class CreateInvoiceDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :invoice_details do |t|
      t.string :treatment
      t.decimal :price
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
