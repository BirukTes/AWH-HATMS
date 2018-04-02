class CreatePatients < ActiveRecord::Migration[5.1]
  def change
    create_table :patients do |t|
      t.string :allergies
      t.boolean :diabetes
      t.boolean :asthma
      t.boolean :smokes
      t.boolean :alcoholic
      t.text :medicalTestsResults
      t.text :nextOfKin
      t.boolean :isPrivate

      t.timestamps
    end
  end
end
