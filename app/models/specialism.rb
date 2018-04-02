class Specialism < ApplicationRecord
  # Composite-UID
  self.primary_keys :staff, :speciality

  # Association
  belongs_to :staff
  belongs_to :speciality
end
