class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :town
      t.string :postcode
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
