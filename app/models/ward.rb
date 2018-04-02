class Ward < ApplicationRecord
  has_many :teams, through: :allocations
  has_many :patients, through: :admissions

end
