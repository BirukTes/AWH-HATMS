# Allows to create Ward, has many allocations to teams and admissions to patients
#
# @author Bereketab Gulai

# == Schema Information
#
# Table name: wards
#
#  id            :bigint(8)        not null, primary key
#  name          :string
#  wardNumber    :integer
#  numberOfBeds  :integer
#  bedStatus     :integer
#  patientGender :string
#  deptName      :string
#  isPrivate     :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Ward < ApplicationRecord
  has_many :allocations
  has_many :teams, through: :allocations
  has_many :admissions
  has_many :patients, through: :admissions

  validates(:name, presence: true)
  validates(:wardNumber, presence: true)
  validates(:numberOfBeds, presence: true)
  validates(:patientGender, presence: true)
  validates(:deptName, presence: true)
  # Ward number cannot be used again
  validates_uniqueness_of(:wardNumber, scope: :wardNumber)

  human_attribute_name(:wardNumber)
  human_attribute_name(:numberOfBeds)
  human_attribute_name(:patientGender)
  human_attribute_name(:deptName)

  after_create(:set_bed_status)

  # Sets the bed status
  #
  def set_bed_status
    self.bedStatus = self.numberOfBeds
    self.save
  end

  # TODO future refactor should get even wards are full and indicate this in the list
  #
  # Gets the private or non private wards with given patient, gender
  #
  # @params[patient]
  # @return [Wards]
  def self.ward_options(patient)
    if patient.isPrivate
      where('"patientGender" = ? AND ("bedStatus" != 0 OR "bedStatus" != Null) AND "isPrivate" = true', "#{patient.person.gender}").all
    else
      where('"patientGender" = ? AND ("bedStatus" != 0 OR "bedStatus" != Null) AND "isPrivate" = false', "#{patient.person.gender}").all

      # From either choice will be mapped
    end
  end
end
