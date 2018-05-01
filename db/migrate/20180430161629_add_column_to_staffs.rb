class AddColumnToStaffs < ActiveRecord::Migration[5.1]
  def change
    add_column :staffs, :active, :boolean, default: false, null: false
  end
end
