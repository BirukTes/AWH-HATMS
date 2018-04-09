class JobTitle < ApplicationRecord
  # Many-to-many association through the corresponding join table
  has_many :jobs
  has_many :staffs, through: :jobs

  validates :title, presence: true
end
