# == Schema Information
#
# Table name: specialisms
#
#  id            :bigint(8)        not null, primary key
#  staff_id      :bigint(8)
#  speciality_id :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Specialism, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
