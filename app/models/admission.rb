class Admission < ApplicationRecord
  # Only association here, no composite key
  belongs_to :ward
  belongs_to :patient
end
