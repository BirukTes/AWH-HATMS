class Prescription < ApplicationRecord
  belongs_to :patient
  has_many :drugs, through: :medications
end
