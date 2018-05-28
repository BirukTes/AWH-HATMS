# == Schema Information
#
# Table name: jobs
#
#  id           :bigint(8)        not null, primary key
#  staff_id     :bigint(8)
#  job_title_id :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Job < ApplicationRecord
  # Composite-UID, discarding as causing error
  # self.primary_keys :staff, :job_title

  # Association
  belongs_to :staff
  belongs_to :job_title
end
