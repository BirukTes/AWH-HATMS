# Handles patient system, with methods to view, create and update
#
# @author Bereketab Gulai
class PatientsController < ApplicationController
  # Permitted formats
  respond_to(:html, :js, :json)

  before_action(:set_patient, only: [:show, :edit, :update, :destroy])


  # Handles GET method for index page (all patients/collection)
  def index
    authorize(:patient)
    @patients = Patient.all

    respond_with(@patients) do |format|
      format.xlsx { render xlsx: 'index', filename: 'Patients', disposition: 'attachment',
                           xlsx_created_at: Time.now, xlsx_author: 'AllsWell Hospital' }
    end
  end

  # Handles GET method for show/view page, the individual patient's page
  def show
  end

  # Handles GET method for new page, the register patient page
  def new
    authorize(:patient)
    @patient = Patient.new


    # Initialise the fields, for corresponding model
    @patient.build_person
    @patient.person.build_address

    # Pass the param for redirection, after saving or error
    if params.include?(:admission_register)
      session[:admission_register] = true
      puts('sessioned admission_register')
    end
  end

  # Handles the POST saving/creation of the patient, with parameters from the form
  def create
    authorize(:patient)
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        if session[:admission_register]
          puts('Session admission_register use')
          format.html { redirect_to(new_admission_path(dateOfBirth: @patient.person.dateOfBirth, lastName: @patient.person.lastName),
                                    notice: 'Patient registration successful') }
        else
          format.html { redirect_to(patients_path, notice: 'Patient registration successful') }
        end
      else
        format.js { render :create, status: :unprocessable_entity }
      end
    end
  end


  # Handles GET method for edit page
  def edit
  end

  # Handles POST method for show/view page, the individual patient's page
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        # Update the patient within admission form page
        if params.include?(:update_patient)
          @update_patient_successful = true
          format.js
        else
          format.html { redirect_to(patients_path, notice: 'Patient updated!') }
        end
      else
        if params.include?(:update_patient)
          @update_patient_fail = true
          # respond_with(@patient)
          format.js
        else
          respond_with(@patient)
        end
      end
    end
  end

  # Handles PUT/PATCH method for show/view page
  def destroy
    # TODO instead suspend, patients are not be deleted
    # @patient.destroy
    # redirect_to(patients_path, notice: 'Patient deleted')
  end

  private

  # Permitted parameters
  def patient_params
    params.require(:patient).permit(:id, :allergies, :diabetes, :asthma, :smokes, :alcoholic, :medicalTestsResults, :nextOfKin,
                                    :isPrivate, :email, :admission_register, :update_patient, :occupation,
                                    person_attributes: [:id, :firstName, :lastName, :gender, :dateOfBirth, :telHomeNo, :telMobileNo,
                                                        address_attributes: [:id, :houseNumber, :street, :town, :postcode]])
  end

  # Sets/declares the record from the database by the id passed in
  def set_patient
    authorize(:patient)
    @patient = Patient.find(params[:id])
  end

end
