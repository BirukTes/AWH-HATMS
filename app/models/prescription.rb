# Allows to make diagnosis prescription
#
# @author Bereketab Gulai

# == Schema Information
#
# Table name: prescriptions
#
#  id              :bigint(8)        not null, primary key
#  date            :date
#  dosage          :string
#  treatmentLength :integer
#  issuedBy        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  diagnosis_id    :bigint(8)
#

class Prescription < ApplicationRecord
  belongs_to :diagnosis
  has_many(:medications, dependent: :destroy)
  has_many(:drugs, through: :medications, dependent: :destroy)

  accepts_nested_attributes_for(:medications, allow_destroy: true)

  human_attribute_name(:treatmentLength)
  human_attribute_name(:issuedBy)

  # Validates all fields
  validates(:date, presence: true)
  validates(:dosage, presence: true)
  validates(:treatmentLength, presence: true)
  validates(:issuedBy, presence: true)
end
