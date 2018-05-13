class Patient < ApplicationRecord

  # Many to Many association through join table, cascade delete
  has_many :admissions
  # Indirect associations
  has_many :invoices, through: :admissions
  has_many :diagnosis, through: :admissions
  has_many :prescriptions, through: :diagnosis
  #

  scope(:prescriptions, -> { admissions.each { |a| a.diagnoses.each { |d| d.prescriptions } } })


  has_one :person, as: :personalDetail, dependent: :destroy

  accepts_nested_attributes_for(:person, update_only: true, allow_destroy: true)
  validates_associated(:person, presence: true)

  def self.find_patient(dateOfBirth, lastName)
    if dateOfBirth && lastName
      person = Person.find_person_patient(dateOfBirth, lastName)

      person ? find(person.personalDetail_id) : nil
    end
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
