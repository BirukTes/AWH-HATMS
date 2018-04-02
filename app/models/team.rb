class Team < ApplicationRecord
  has_many :wards, through: :allocations
  has_many :staffs
end
