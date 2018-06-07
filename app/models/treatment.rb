# Model modified to be considered as notes holder for a patient during their admission
#
# @note name still kept to reserve the requirement, should take change in future maintenance
#
# @author Bereketab Gulai

# == Schema Information
#
# Table name: treatments
#
#  id           :bigint(8)        not null, primary key
#  date         :date
#  note         :text
#  issuedBy     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  admission_id :bigint(8)
#

# TODO Name of treatment requires changing
class Treatment < ApplicationRecord
  belongs_to :admission
  has_one(:patient, through: :admission)

  validates(:note, presence: true)
end
