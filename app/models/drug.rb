class Drug < ApplicationRecord
  has_many :medications
  has_many :prescriptions, through: :medications
end
