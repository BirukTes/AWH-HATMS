# == Schema Information
#
# Table name: specialisms
#
#  id            :bigint(8)        not null, primary key
#  staff_id      :bigint(8)
#  speciality_id :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Specialism < ApplicationRecord
  # Composite-UID, Removing this due to error
  # self.primary_keys :staff, :speciality

  # Association
  belongs_to :staff
  belongs_to :speciality
end
