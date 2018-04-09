class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :firstName, null: false
      t.string :lastName, null: false
      t.date :dateOfBirth, null: false
      t.string :gender, null: true
      t.integer :telHomeNo, null: true
      t.integer :telMobileNo, null: true
      # Required for Polymorphic association
      t.references :personalDetail, polymorphic: true, index: true

      t.timestamps
    end
  end
end
