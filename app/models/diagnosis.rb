# Handles diagnosis model, child of admission with access to patient and
# has many prescriptions,has access to patient through admission parent
#
# @author Bereketab Gulai

# == Schema Information
#
# Table name: diagnoses
#
#  id           :bigint(8)        not null, primary key
#  title        :string
#  description  :string
#  admission_id :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Diagnosis < ApplicationRecord
  belongs_to :admission
  has_many :prescriptions
  has_one(:patient, through: :admission)

  # Validates all fields
  validates(:title, presence: true)
  validates(:description, presence: true)
end
