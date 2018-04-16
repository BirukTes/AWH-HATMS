class PatientsController < ApplicationController
  def index
    @patients = Patient.all
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def new
    @patient = Patient.new
    @patient.build_person
    @patient.person.build_address
  end

  def create
    @patient = Patient.new(patient_params)

    if @patient.save!
            redirect_to(patients_path(@patient), notice: 'Patient registration successful')
    else
      # puts(@patient.errors.inspect)
      # Pass the errors, to the instance variable
      @errors = @patient.errors.full_message
      render :new
    end
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])

    if @patient.update_attributes!(patient_params)
      redirect_to(patients_path(@patient), notice: 'Patient updated!')
    else
      @errors = @meal_plan.errors.full_messages
      render :edit
    end
  end

  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy!
  redirect_to(patients_path, notice: 'Patient deleted')
  end

  private

  def patient_params
    params.require(:patient).permit(:id, :allergies, :diabetes, :asthma, :smokes, :alcoholic, :medicalTestsResults, :nextOfKin,
                                    :isPrivate, :email,
                                    person_attributes: [:firstName, :lastName, :gender, :dateOfBirth, :telHomeNo, :telMobileNo,
                                                        address_attributes: [:houseNumber, :street, :town, :postcode]])
  end
end
