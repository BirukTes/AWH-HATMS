class CreateDrugs < ActiveRecord::Migration[5.1]
  def change
    # Having no default id column has cause many issues such as
    # no id column exists as it is expected everywhere else
    # create_table :drugs,  { :id => false } do |t|
    create_table :drugs do |t|
      t.string :code,  null: false, index: true
      t.string :name,  null: false

      t.timestamps
    end

  end
end
