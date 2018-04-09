class Patient < ApplicationRecord
  # One to Many association, cascade delete
  has_many :prescriptions, dependent: :destroy
  has_many :treatments, dependent: :destroy

  # Many to Many association through join table, cascade delete
  has_many :Admissions

  has_one :person, as: :personalDetail, dependent: :destroy

end
