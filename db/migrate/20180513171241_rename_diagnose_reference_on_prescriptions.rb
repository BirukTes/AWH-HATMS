class RenameDiagnoseReferenceOnPrescriptions < ActiveRecord::Migration[5.1]
  def change
    rename_column :prescriptions, :diagnose_id, :diagnosis_id
  end
end
