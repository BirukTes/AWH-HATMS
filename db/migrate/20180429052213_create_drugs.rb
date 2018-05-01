class CreateDrugs < ActiveRecord::Migration[5.1]
  def change
    create_table :drugs do |t|
      t.string :code, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
