class Team < ApplicationRecord
  # One-to-many
  has_many :allocations

  # Many-to-many association through the corresponding join table
  has_many :wards, through: :allocations

  # One-to-many
  has_many :staffs
end
