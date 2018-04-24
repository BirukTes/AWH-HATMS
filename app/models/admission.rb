class Admission < ApplicationRecord
  # Only association here, no composite key
  belongs_to :ward
  belongs_to :patient

  validates(:admissionDate, presence: true)
  validates(:patient_id, presence: true)
  validates(:ward_id, presence: true)
  validates(:team_id, presence: true)


  def self.admitted?(patient_id)
    if Admission.find_by(patient_id: patient_id)
      Admission.find_by(patient_id: patient_id).status == 'Admitted'
    end
  end
end
