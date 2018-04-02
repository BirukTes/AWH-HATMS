class Drug < ApplicationRecord
  has_many :prescriptions, through: :medications
end
