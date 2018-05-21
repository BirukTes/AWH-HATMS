class ChangeColumnIsPrivateOnWards < ActiveRecord::Migration[5.1]
  def change
    change_column :wards, :isPrivate, :boolean, default: false
  end
end
