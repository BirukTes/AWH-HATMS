# Provides junction between teams and wards
#
# @author Bereketab Gulai

# == Schema Information
#
# Table name: specialities
#
#  id         :bigint(8)        not null, primary key
#  speciality :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Speciality < ApplicationRecord
  # Setup many-to-many association through the junction table
  has_many(:specialisms)
  has_many(:staffs, through: :specialisms)

  validates(:speciality, presence: true)
end
