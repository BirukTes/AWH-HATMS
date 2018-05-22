class Admission < ApplicationRecord
  # Only association here, no composite key
  belongs_to :ward
  belongs_to :patient
  has_one(:invoice, dependent: :destroy)
  # One to Many association, cascade delete
  has_many(:diagnoses, dependent: :destroy)

  validates(:admissionDate, presence: true)
  validates(:patient_id, presence: true)
  validates(:ward_id, presence: true)

  human_attribute_name(:admissionDate)
  human_attribute_name(:dischargeDate)

  # ransack_alias(:patient, :patient_first_name_or_patient_last_name)

  # ransacker :full_name do |parent|
  #   Arel::Nodes::InfixOperation.new('||',
  #                                   Arel::Nodes::InfixOperation.new('||', parent.table[:firsName], ' '),
  #                                   parent.table[:lastName])
  # end
  #
  # ransacker :patientDob do |parent|
  #   Arel.sql('person.dateOfBirth')
  # end

  enum status: { admitted: 'Admitted', discharged: 'Discharged' }

  # Check if the patient is admitted
  #
  # @return [true/false:boolean]
  def self.admitted?(patient_id)
    # Get all occurrences and loop see if there is current admission
    where(patient_id: patient_id)&.all&.each do |admission|
      if admission.status == 'admitted'
        return true
      end
    end
    # Otherwise false
    false
  end

  # Gets the current admissions
  #
  # @return [[name:string, id:integer],[name:string, id:integer]]
  def self.find_admitted_patients(ward_id)
    # Get the current admissions, extract the patient id and find them
    where(ward_id: ward_id, status: 'admitted').all.map do |admission|
      patients_option(admission.patient, admission)
    end
  end

  # Gets the current admissions
  #
  # @return [[name:string, id:integer],[name:string, id:integer]]
  def self.find_admitted_diagnosed_patients(ward_id, patient_id)
    # Get the current admissions, extract the patient id and find them
    where(ward_id: ward_id, patient_id: patient_id, status: 'admitted').first
  end


  # Get the current admissions and not authorised
  #
  # @return [[ Admission# name : string, id:string]]
  def self.find_discharged_without_invoice_patients(ward_id)
    # This is returned as [[ Ad# name, id],[Ad# name, id]], jagged array
    where(ward_id: ward_id, status: 'discharged').all.map do |admission|
      if admission.patient.isPrivate && admission.invoice.nil?
        patients_option(admission.patient, admission)
      end

      # Remove/reject any nulls returned from this function
    end.reject { |patients_option| patients_option.nil? }
  end

  # Gets the current admissions and discharge not authorised
  #
  # @return [[name:string, id:integer],[name:string, id:integer]]
  def self.find_discharge_unauthorised_admitted_patients(ward_id)
    # ...Extract the admission id and find them
    where(ward_id: ward_id, status: 'admitted', dischargeDate: nil).all.map do |admission|
      patients_option(admission.patient, admission)
    end
  end

  # TODO refactor to find controller
  # Class method, used by +find_discharged_without_invoice_patients+
  #
  # Gets array of name and id of passed in patient
  #
  # @return [Admission# name : string, id:string]
  def self.patients_option(patient, admission)
    #  Add admission number beginning of the array, NOTICE the end with '|' as delimiter, requires extraction
    ['Admission #' + admission.id.to_s + ' ' + patient.person.firstName + ' ' + patient.person.lastName,
     patient.id.to_s + '|' + admission.id.to_s]
  end


  # Class method
  #
  # Finds admission with discharge due, runs the method
  def self.set_status_discharge(admission_id)
    find(admission_id).auto_discharge
  end

  # Discharges a scheduled, authorised discharge date
  def auto_discharge
    # Admitted / Discharged
    self.update(status: 'Discharged')
    # Return the one bed, and update the ward bedStatus
    # Just incase goes above max, validation is included
    self.ward.update(bedStatus: if self.ward.bedStatus >= self.ward.numberOfBeds
                                  # Don't add anything, already max?
                                  0
                                else
                                  self.ward.bedStatus + 1
                                end)
  end
end