class ChangeDataTypeForPeople < ActiveRecord::Migration[5.1]
  def change
    change_column :people, :telHomeNo, :string
    change_column :people, :telMobileNo, :string
  end
end
