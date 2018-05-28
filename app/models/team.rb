# == Schema Information
#
# Table name: teams
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  head       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Team < ApplicationRecord
  # One-to-many
  has_many :allocations

  # Many-to-many association through the corresponding join table
  has_many :wards, through: :allocations

  # One-to-many
  has_many :staffs

   validates(:name, presence: true)
   validates(:head, presence: true)
end
