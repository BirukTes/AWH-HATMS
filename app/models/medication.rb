class Medication < ApplicationRecord
  # Composite UID
  self.primary_keys :prescription, :drug

  # Foreign keys
  belongs_to :prescription
  belongs_to :drug
end
