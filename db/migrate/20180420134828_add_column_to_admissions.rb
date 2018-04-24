class AddColumnToAdmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :admissions, :status, :string
  end
end
