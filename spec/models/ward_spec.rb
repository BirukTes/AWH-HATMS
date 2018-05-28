# == Schema Information
#
# Table name: wards
#
#  id            :bigint(8)        not null, primary key
#  name          :string
#  wardNumber    :integer
#  numberOfBeds  :integer
#  bedStatus     :integer
#  patientGender :string
#  deptName      :string
#  isPrivate     :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Ward, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
