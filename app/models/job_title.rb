class JobTitle < ApplicationRecord
  has_many :staffs, through: :jobs
end
