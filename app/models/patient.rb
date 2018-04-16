class Patient < ApplicationRecord
  # One to Many association, cascade delete
  has_many :prescriptions, dependent: :destroy
  has_many :treatments, dependent: :destroy

  # Many to Many association through join table, cascade delete
  has_many :Admissions

  has_one :person, as: :personalDetail, dependent: :destroy

  accepts_nested_attributes_for(:person, allow_destroy: true)

  def self.find_patient(dateOfBirth, lastName)
    if dateOfBirth && lastName
      person = Person.find_person_patient(dateOfBirth, lastName)

      find(person.personalDetail_id)
    end
  end
end
