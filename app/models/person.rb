class Person < ApplicationRecord
  has_one :address, dependent: :destroy
  # Polymorphic association creation
  belongs_to :personalDetail, polymorphic: true, optional: true

  validates :firstName, presence: true
  validates :lastName, presence: true
  validates :gender, presence: true

  accepts_nested_attributes_for(:address, allow_destroy: true)

  # Class method, can be accessed without instantiation
  # @param dateOfBirth
  # @param lastName
  # @return Person
  def self.find_person_patient(dateOfBirth, lastName)
    # Make sure they  are not null
    where(personalDetail_type: 'Patient', dateOfBirth: dateOfBirth, lastName: lastName).first
  end
end
