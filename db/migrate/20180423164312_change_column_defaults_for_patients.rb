class ChangeColumnDefaultsForPatients < ActiveRecord::Migration[5.1]
  def change
    change_column :patients, :diabetes, :boolean, default: false
    change_column :patients, :asthma, :boolean, default: false
    change_column :patients, :smokes, :boolean, default: false
    change_column :patients, :alcoholic, :boolean, default: false
  end
end
