class AddReferenceToPrescriptions < ActiveRecord::Migration[5.1]
  def change
    add_reference :prescriptions, :diagnosis, foreign_key: true
    remove_reference :prescriptions, :patient, foreign_key: true
    remove_reference :prescriptions, :admission, foreign_key: true
  end
end
