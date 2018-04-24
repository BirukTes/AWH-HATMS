class ChangeColumnDefaultForPatients < ActiveRecord::Migration[5.1]
  def change
    change_column :patients, :isPrivate, :boolean, default: false
  end
end
