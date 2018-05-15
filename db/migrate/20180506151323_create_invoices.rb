class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.date :date
      t.date :dateDue
      t.boolean :paymentReceived
      t.references :patient, foreign_key: true

      t.timestamps
    end
  end
end
