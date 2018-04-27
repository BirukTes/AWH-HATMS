class Admission < ApplicationRecord
  # Only association here, no composite key
  belongs_to :ward
  belongs_to :patient

  validates(:admissionDate, presence: true)
  validates(:patient_id, presence: true)
  validates(:ward_id, presence: true)
  validates(:team_id, presence: true)

  human_attribute_name(:admissionDate)
  human_attribute_name(:admissionDate)

  def self.admitted?(patient_id)
    if Admission.find_by(patient_id: patient_id)
      Admission.find_by(patient_id: patient_id).status == 'Admitted'
    end
  end

  def self.find_admitted_patients(ward_id)
    patients = []
    admissions = where(ward_id: ward_id, status: 'Admitted').all
    if admissions
      i = 0
      admissions.each do |admission|
        patients[i] = Patient.find(admission.patient_id)
        i += 1
      end
    end

    return patients
  end
end
