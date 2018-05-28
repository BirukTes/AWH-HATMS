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

# @author Bereketab Gulai
#
#
class Treatment < ApplicationRecord
  belongs_to :admission
  has_one :patient, through: :admission

  validates(:note, presence: true)
end
