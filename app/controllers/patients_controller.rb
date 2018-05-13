class PatientsController < ApplicationController
  # Permitted formats
  respond_to(:html, :js, :json)

  before_action(:set_patient, only: [:show, :edit, :update, :destroy])

  # Authorisation callbacks
  after_action(:verify_authorized)


  def index
    authorize(:patient)
    @patients = Patient.all
  end

  def show
  end

  def new
    authorize(:patient)
    @patient = Patient.new

    @patient.build_person
    @patient.person.build_address

    # Pass the param for redirection
    if params.include?(:admission_register)
      session[:admission_register] = true
      puts('sessioned')
    end
  end

  def create
    authorize(:patient)
    @patient = Patient.new(patient_params)

    if @patient.save
      if session[:admission_register]
        puts('scs')
        redirect_to(new_admission_path(dateOfBirth: @patient.person.dateOfBirth, lastName: @patient.person.lastName),
                    notice: 'Patient registration successful')
      else
        redirect_to(patients_path(@patient), notice: 'Patient registration successful')
      end
    else
      puts(@patient.errors.inspect)
      # Pass the errors, to the instance variable
      @errors = @patient.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @patient.update(patient_params)
      if params.include?(:update_patient)
        @update_patient = true
        @update_patient_successful = true
        flash[:notice] = 'Patient updated!'
        respond_with(@patient)
      else
        redirect_to(patients_path, notice: 'Patient updated!')
      end
    else
      if params.include?(:update_patient)
        @update_patient = true
        respond_with(@patient)
      else
        @errors = @meal_plan.errors.full_messages
        render :edit
      end
    end
  end

  def destroy
    @patient.destroy
    redirect_to(patients_path, notice: 'Patient deleted')
  end

  private

  def patient_params
    params.require(:patient).permit(:id, :allergies, :diabetes, :asthma, :smokes, :alcoholic, :medicalTestsResults, :nextOfKin,
                                    :isPrivate, :email, :admission_register, :update_patient, :occupation,
                                    person_attributes: [:id, :firstName, :lastName, :gender, :dateOfBirth, :telHomeNo, :telMobileNo,
                                                        address_attributes: [:id, :houseNumber, :street, :town, :postcode]])
  end

  def set_patient
    authorize(:patient)
    @patient = Patient.find(params[:id])
  end
end
