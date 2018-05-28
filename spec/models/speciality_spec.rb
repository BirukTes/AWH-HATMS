# == Schema Information
#
# Table name: specialities
#
#  id         :bigint(8)        not null, primary key
#  speciality :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Speciality, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
