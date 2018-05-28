# == Schema Information
#
# Table name: addresses
#
#  id          :bigint(8)        not null, primary key
#  houseNumber :string           not null
#  street      :string           not null
#  town        :string           not null
#  postcode    :string           not null
#  person_id   :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Address, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
