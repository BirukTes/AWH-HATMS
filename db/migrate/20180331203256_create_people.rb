class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
      t.date :dateOfBirth
      t.integer :telHomeNo
      t.integer :telMobileNo
      t.string :gender

      t.timestamps
    end
  end
end
