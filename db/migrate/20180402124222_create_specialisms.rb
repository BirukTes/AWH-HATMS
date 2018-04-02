class CreateSpecialisms < ActiveRecord::Migration[5.1]
  def change
    create_table :specialisms do |t|
      t.references :staff, foreign_key: true
      t.references :speciality, foreign_key: true

      t.timestamps
    end
  end
end
