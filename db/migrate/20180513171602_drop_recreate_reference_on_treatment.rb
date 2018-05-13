class DropRecreateReferenceOnTreatment < ActiveRecord::Migration[5.1]
  def change
    remove_reference :treatments, :admission, foreign_key: true
    add_reference :treatments, :diagnosis, foreign_key: true
  end
end
