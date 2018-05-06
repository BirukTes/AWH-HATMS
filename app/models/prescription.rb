class Prescription < ApplicationRecord
  belongs_to :patient
  has_many :medications
  has_many :drugs, through: :medications

  accepts_nested_attributes_for(:medications, allow_destroy: true)

  human_attribute_name(:treatmentLength)
  human_attribute_name(:issuedBy)

  validates(:date, presence: true)
  validates(:dosage, presence: true)
  validates(:treatmentLength, presence: true)
  validates(:issuedBy, presence: true)
end
