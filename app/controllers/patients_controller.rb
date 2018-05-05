class PatientsController < ApplicationController

  before_action(:set_patient, only: [:show, :edit, :update, :destroy])

  # Authorisation callbacks
  after_action(:verify_authorized, except: :index)
  after_action(:verify_policy_scoped, only: :index)

  def index
    @patients = policy_scope(Patient)
  end

  def show
  end

  def new
    @patient = Patient.new
    authorize @patient

    @patient.build_person
    @patient.person.build_address

    # Pass the param for redirection
    if params.include?(:admission_register)
      session[:admission_register] = true
      puts('sessioned')
    end
  end

  def create
    @patient = Patient.new(patient_params)
    authorize @patient

    # if @patient.save
      if session[:admission_register]
        puts('scs')
      redirect_to(new_admission_path(dateOfBirth: @patient.person.dateOfBirth, lastName: @patient.person.lastName),
                  notice: 'Patient registration successful')
      else
        redirect_to(patients_path(@patient), notice: 'Patient registration successful')
      end
    # else
      # puts(@patient.errors.inspect)
      # Pass the errors, to the instance variable
      # @errors = @patient.errors.full_messages
      # render :new
    # end
  end

  def edit
  end

  def update
    if @patient.update!(patient_params)
      redirect_to(patients_path, notice: 'Patient updated!')
    else
      @errors = @meal_plan.errors.full_messages
      render :edit
    end
  end

  def destroy
    @patient.destroy!
    redirect_to(patients_path, notice: 'Patient deleted')
  end

  private

  def patient_params
    params.require(:patient).permit(:id, :allergies, :diabetes, :asthma, :smokes, :alcoholic, :medicalTestsResults, :nextOfKin,
                                    :isPrivate, :email, :admission_register,
                                    person_attributes: [:id, :firstName, :lastName, :gender, :dateOfBirth, :telHomeNo, :telMobileNo,
                                                        address_attributes: [:id, :houseNumber, :street, :town, :postcode]])
  end

  def set_patient
    @patient = Patient.find(params[:id])
    authorize @patient
  end
end
