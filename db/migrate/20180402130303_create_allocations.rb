class CreateAllocations < ActiveRecord::Migration[5.1]
  def change
    create_table :allocations do |t|
      t.references :ward, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
