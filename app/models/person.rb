class Person < ApplicationRecord
  # One-to-one association
  has_one :address, dependent: :destroy

  # Polymorphic association, creates multiple table inheritance at database level
  belongs_to :personalDetail, polymorphic: true, optional: true

  validates :firstName, presence: true
  validates :lastName, presence: true
  validates :gender, presence: true

  # To allow creation of address during creation person
  accepts_nested_attributes_for(:address, allow_destroy: true)

  # Class method, can be accessed without instantiation
  # Gets the a patient with the details
  #
  # @param dateOfBirth
  # @param lastName
  # @return [Person] person object, specific to the patient
  def self.find_person_patient(dateOfBirth, lastName)
    # Make sure they  are not null
    where(personalDetail_type: 'Patient', dateOfBirth: dateOfBirth, lastName: lastName).first
  end
end
