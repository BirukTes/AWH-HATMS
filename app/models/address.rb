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

class Address < ApplicationRecord
  belongs_to(:person, inverse_of: :address)
end
