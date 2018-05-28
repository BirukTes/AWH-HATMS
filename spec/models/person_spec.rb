# == Schema Information
#
# Table name: people
#
#  id                  :bigint(8)        not null, primary key
#  firstName           :string           not null
#  lastName            :string           not null
#  dateOfBirth         :date             not null
#  gender              :string
#  telHomeNo           :string
#  telMobileNo         :string
#  personalDetail_type :string
#  personalDetail_id   :bigint(8)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe Person, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
