class Speciality < ApplicationRecord
  # Setup many-to-many association through the junction table
  has_many :specialisms
  has_many :staffs, through: :specialisms

  validates :speciality, presence: true
end
