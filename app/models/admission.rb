# frozen_string_literal: true

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

  # Creates the methods for each, to retrieve (admission.admitted),
  # set (admission.discharged!), and check for boolean (admission.scheduled?)
  #
  enum status: { admitted: 'Admitted', discharged: 'Discharged', scheduled: 'Scheduled' }

  # Runs the reminder method asynchronously, as defined below
  after_create(:reminder)

  # Notify the patient of their before admission date and time
  def reminder
    account_sid = Rails.application.secrets.twilio_account_sid
    @client = Twilio::REST::Client.new(account_sid, Rails.application.secrets.twilio_auth_token)

    # Setup the message
    time_str = admissionDate.localtime.strftime('%I:%M%p on %d %b, %Y')

    # The text layout/formatting matters, in terms how it is displayed on the receiving device
    reminder = "Hi #{patient.person.firstName}.

Just a reminder that you have an appointment for
admission at #{time_str}.


Regards,

Allswell Hospital
King Charles RD,
Surbiton,
KT5 9BH
+441424400647
allswell.hospital@outlook.com"
    message = @client.messages.create(
        from: Rails.application.secrets.twilio_phone_from,
        to: Rails.application.secrets.twilio_phone_to,
        body: reminder)
  end

  # Specifies the time before which the reminder should be sent
  #
  # @return [Time]
  def when_to_run
    minutes_before_appointment = 5.minutes
    admissionDate - minutes_before_appointment
  end

  # Sets delayed job to handle the reminder for the specified date and time
  handle_asynchronously(:reminder, run_at: proc { |i| i.when_to_run })

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

  # Check if the patient is admitted
  #
  # @params [patient_id] specify the patient id, to identify
  # @return [true/false:boolean] true indicates admitted, otherwise false
  def self.admitted?(patient_id)
    # Get all occurrences and loop see if there is current admission
    where(patient_id: patient_id)&.all&.each do |admission|
      return true if admission.status == 'admitted'
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
    end.reject(&:nil?)
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

  # TODO: refactor to find controller
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
    update(status: 'Discharged')
    # Return the one bed, and update the ward bedStatus
    # Just incase goes above max, validation is included
    ward.update(bedStatus: if ward.bedStatus >= ward.numberOfBeds
                             # Don't add anything, already max?
                             0
                           else
                             ward.bedStatus + 1
                           end)
  end
end
