class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :houseNumber, null: false
      t.string :street, null: false
      t.string :town, null: false
      t.string :postcode, null: false
      t.references :people, foreign_key: true

      t.timestamps
    end
  end
end
