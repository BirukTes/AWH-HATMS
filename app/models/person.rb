class Person < ApplicationRecord

  has_one :address

  validates :firstName, :presence => true
  validates :lastName, :presence => true
  validates :dateOfBirth, :presence => true
  validates :gender, :presence => true
end
