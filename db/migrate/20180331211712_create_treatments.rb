class CreateTreatments < ActiveRecord::Migration[5.1]
  def change
    create_table :treatments do |t|
      t.date :date
      t.text :note
      t.string :issuedBy
      t.references :patient, foreign_key: true

      t.timestamps
    end
  end
end
