class Person < ApplicationRecord

  # One-to-one association
  has_one :address, dependent: :destroy
  # Polymorphic association, creates multiple table inheritance at database level
  belongs_to :personalDetail, polymorphic: true, optional: true

  # To allow creation of address during creation person
  accepts_nested_attributes_for(:address, allow_destroy: true)

  # Validate uniqueness the person using the date of birth column
  validates(:firstName, presence: true, :uniqueness => { :case_sensitive => false, scope: :dateOfBirth })
  validates(:lastName, presence: true, :uniqueness => { :case_sensitive => false, scope: :dateOfBirth })
  validates(:gender, presence: true)
  validates_associated(:address, presence: true)


  # Concatenates the address
  #
  # @return [String] the full address
  def full_address
    # Check in case of null, otherwise this should not be the case address must be provided
    if address
      (address.houseNumber + ', ' + address.street + ', ' + address.town + ', ' + address.postcode)
    else
      # Otherwise replace nil with:
      '--'
    end
  end

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
