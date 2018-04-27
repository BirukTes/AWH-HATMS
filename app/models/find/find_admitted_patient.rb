class Find::FindAdmittedPatient
  include ActiveModel::Model

  attr_accessor(:dateOfAdmission, :lastName)

  validates :dateOfAdmission, presence: true
  validates :lastName, presence: true
end
