class CreateMedications < ActiveRecord::Migration[5.1]
  def change
    create_table :medications do |t|
      t.references :prescription, foreign_key: true
      t.references :drug, foreign_key: true

      t.timestamps
    end
  end
end
