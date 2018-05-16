class Patient < ApplicationRecord

  # One-to-one polymorphic relationship
  has_one :person, as: :personalDetail, dependent: :destroy
  # Many to Many association through join table, cascade delete
  has_many :admissions
  # Indirect associations, ActiveRecord will handle joins, using inner join
  has_many :invoices, through: :admissions
  has_many :diagnoses, through: :admissions
  has_many :prescriptions, through: :diagnoses
  # This relationship can removed in the future refactoring
  has_many :treatments, dependent: :destroy

  # To allow creation of person/personal details during creation patient
  accepts_nested_attributes_for(:person, update_only: true, allow_destroy: true)

  # The only field required for this class
  validates(:nextOfKin, presence: true)
  # To validate person's attributes, first/last name...and it is corresponding associations, address
  validates_associated(:person, presence: true)

  # Finds a patient with date of birth and last name
  #
  # @return [Patient] otherwise nil, no patient with details
  def self.find_patient(dateOfBirth, lastName)
      person = Person.find_person_patient(dateOfBirth, lastName)

      person ? find(person.personalDetail_id) : nil
  end

  # @return [patient]
  def self.get_patient(patient_id)
    find(patient_id)
  end


  # def self.decorate
  #   # Optimise subsequent calls with memoisation (||=)
  #   @decorate ||= PatientDecorator.new(self)
  # end
end
