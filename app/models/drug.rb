# Handles drug model
#
# @author Bereketab Gulai

# == Schema Information
#
# Table name: drugs
#
#  id         :bigint(8)        not null, primary key
#  code       :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Drug < ApplicationRecord
  has_many :medications
  has_many :prescriptions, through: :medications

  # Validate presence and uniqueness
  validates(:name, presence: true, uniqueness: true)
  validates(:code, presence: true, uniqueness: true)
end
