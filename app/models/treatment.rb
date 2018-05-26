# @author Bereketab Gulai
#
#
class Treatment < ApplicationRecord
  belongs_to :admission
  has_one :patient, through: :admission

  validates(:note, presence: true)
end
