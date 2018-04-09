class Specialism < ApplicationRecord
  # Composite-UID, Removing this due to error
  # self.primary_keys :staff, :speciality

  # Association
  belongs_to :staff
  belongs_to :speciality
end
