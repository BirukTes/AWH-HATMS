class CreateWards < ActiveRecord::Migration[5.1]
  def change
    create_table :wards do |t|
      t.string :name
      t.integer :wardNumber
      t.integer :numberOfBeds
      t.integer :bedStatus
      t.string :patientGender
      t.string :deptName
      t.boolean :isPrivate

      t.timestamps
    end
  end
end
