class AddColumnToPatients < ActiveRecord::Migration[5.1]
  def change
    add_column :patients, :occupation, :string
  end
end
