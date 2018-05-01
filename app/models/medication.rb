class Medication < ApplicationRecord
  belongs_to :prescription
  belongs_to :drug
end
