# == Schema Information
#
# Table name: job_titles
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe JobTitle, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
