class CreatePrescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :prescriptions do |t|
      t.date :date
      t.string :dosage
      t.integer :treatmentLength
      t.string :issuedBy
      t.references :patient, foreign_key: true

      t.timestamps
    end

    # add_index :prescriptions, :id
  end
end
