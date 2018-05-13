class AddReferencesToPrescription < ActiveRecord::Migration[5.1]
  def change
    add_reference :prescriptions, :admission, foreign_key: true
  end
end
