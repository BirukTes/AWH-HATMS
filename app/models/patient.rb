class Patient < Person
  # One to Many association, cascade delete
  has_many :prescriptions, dependent: :destroy
  has_many :treatments, dependent: :destroy

  # Many to Many association through join table, cascade delete
  has_many :Admissions, inverse_of: :patient
end
