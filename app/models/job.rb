class Job < ApplicationRecord
  # Composite-UID
  self.primary_keys :staff, :job_title

  # Association
  belongs_to :staff
  belongs_to :job_title
end
