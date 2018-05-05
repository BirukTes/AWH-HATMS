class Admission < ApplicationRecord
  # Only association here, no composite key
  belongs_to :ward
  belongs_to :patient

  validates(:admissionDate, presence: true)
  validates(:patient_id, presence: true)
  validates(:ward_id, presence: true)
  validates(:team_id, presence: true)

  human_attribute_name(:admissionDate)
  human_attribute_name(:dischargeDate)

  enum status: { admitted: 'Admitted', discharged: 'Discharged'}

  def self.admitted?(patient_id)
    # First check if anything exists by the patient id
    if Admission.find_by(patient_id: patient_id)
      # Get all occurrences and loop see if there is current admission
      Admission.where(patient_id: patient_id).all.each do |a|
        if a.status == 'admitted'
          return true
        end
      end
    end
    false
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

  def self.find_discharge_unauthorised_admitted_patients(ward_id)
    patients = []
    admissions = where(ward_id: ward_id, status: 'Admitted', dischargeDate: nil).all
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
