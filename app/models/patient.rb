# Holds patient information, has one personal detail polymoriphic association
#
# @author Bereketab Gulai

# == Schema Information
#
# Table name: patients
#
#  id                  :bigint(8)        not null, primary key
#  allergies           :string
#  diabetes            :boolean          default(FALSE)
#  asthma              :boolean          default(FALSE)
#  smokes              :boolean          default(FALSE)
#  alcoholic           :boolean          default(FALSE)
#  medicalTestsResults :text
#  nextOfKin           :text
#  isPrivate           :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  email               :string
#  occupation          :string
#

class Patient < ApplicationRecord

  # One-to-one polymorphic relationship
  has_one :person, as: :personalDetail, dependent: :destroy

  # Many to Many association through join table, cascade delete
  has_many :admissions, dependent: :destroy

  # Indirect associations, ActiveRecord will handle joins, using inner join
  has_many :invoices, through: :admissions
  has_many :diagnoses, through: :admissions
  has_many :prescriptions, through: :diagnoses
  # Now named +notes+
  has_many :treatments, through: :admissions


  # To allow creation of person/personal details during creation patient
  accepts_nested_attributes_for(:person, update_only: true, allow_destroy: true)


  # The only field required for this class
  validates(:nextOfKin, presence: true)
  # To validate person's attributes, first/last name...and it is corresponding associations, address
  validates_associated(:person, presence: true)


  # Finds a patient with date of birth and last name
  #
  # @param (dateOfBirth) - date of birth to search for
  # @param (lastName) - last name to search for
  # @return [Patient] - otherwise nil, no patient with details
  def self.find_patient(dateOfBirth, lastName)
    person = Person.find_person_patient(dateOfBirth, lastName)

    person ? find(person.personalDetail_id) : nil
  end


  # Provides methods to decorate patient
  # def self.decorate
  #   # Optimise subsequent calls with memoisation (||=)
  #   @decorate ||= PatientDecorator.new(self)
  # end
end
