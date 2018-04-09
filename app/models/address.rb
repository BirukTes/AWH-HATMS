class Address < ApplicationRecord
  belongs_to(:person, inverse_of: :address)
end
