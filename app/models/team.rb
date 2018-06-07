# Allows to create Team, has many allocations to wards, has many ward through allocations
#
# @author Bereketab Gulai

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


  # Name is mandatory at model level, as marked as not null on schema
  validates(:name, presence: true)
  validates_uniqueness_of(:name, scope: :name)

  # Optional needs to be created even without it
  # validates(:head, presence: true)
end
