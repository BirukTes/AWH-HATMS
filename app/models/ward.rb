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

  human_attribute_name(:wardNumber)
  human_attribute_name(:numberOfBeds)
  human_attribute_name(:patientGender)
  human_attribute_name(:deptName)


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
