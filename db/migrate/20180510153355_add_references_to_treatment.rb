class AddReferencesToTreatment < ActiveRecord::Migration[5.1]
  def change
    add_reference :treatments, :admission, foreign_key: true
  end
end
