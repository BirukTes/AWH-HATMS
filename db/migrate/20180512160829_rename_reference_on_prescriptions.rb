class RenameReferenceOnPrescriptions < ActiveRecord::Migration[5.1]
  def change
    rename_column :prescriptions, :diagnosis_id, :diagnose_id
  end
end
