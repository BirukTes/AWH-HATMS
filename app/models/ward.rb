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


  def self.admission_options(patient_gender)
    where('"patientGender" = ? AND ("bedStatus" != 0 OR "bedStatus" != Null)', "#{patient_gender}").map do |ward|
      [ward.name, ward.id]
    end
  end

  def self.get_ward(ward_id)
    find(ward_id)
  end
end
