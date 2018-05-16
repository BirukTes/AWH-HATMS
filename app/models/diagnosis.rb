class Diagnosis < ApplicationRecord
  belongs_to :admission
  has_many :prescriptions
  has_one(:patient, through: :admission)

  validates(:title, presence: true)
  validates(:description, presence: true)

  def self.policy_class
    DiagnosisPolicy
  end
end
