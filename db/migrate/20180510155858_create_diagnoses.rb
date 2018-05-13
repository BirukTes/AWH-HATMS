class CreateDiagnoses < ActiveRecord::Migration[5.1]
  def change
    create_table :diagnoses do |t|
      t.string :title
      t.string :description
      t.references :admission, foreign_key: true

      t.timestamps
    end
  end
end
