# == Schema Information
#
# Table name: allocations
#
#  id         :bigint(8)        not null, primary key
#  ward_id    :bigint(8)
#  team_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Allocation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
