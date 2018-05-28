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

require 'rails_helper'

RSpec.describe Job, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
