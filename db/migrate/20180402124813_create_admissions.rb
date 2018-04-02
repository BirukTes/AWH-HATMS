class CreateAdmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :admissions do |t|
      t.datetime :admissionDate, null: false
      t.datetime :dischargeDate, null: true
      t.text :currentMedications, null: true
      t.text :admissionNote, null: true
      t.references :ward, foreign_key: true
      t.references :patient, foreign_key: true

      t.timestamps
    end
  end
end
