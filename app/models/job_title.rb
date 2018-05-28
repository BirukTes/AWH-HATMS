# == Schema Information
#
# Table name: job_titles
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class JobTitle < ApplicationRecord
  # Many-to-many association through the corresponding join table
  has_many :jobs
  has_many :staffs, through: :jobs

  validates :title, presence: true
end
