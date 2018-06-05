class StaffsController < ApplicationController
  before_action(:set_staff, only: [:show, :edit, :update])


  def index
    authorize(:staff)
    @staffs = Staff.all
  end

  def show
  end

  def new
    authorize(:staff)
    @staff = Staff.new
    @staff.build_person
    @staff.person.build_address
    @staff.specialisms.build
    @staff.jobs.build
  end

  def create
    authorize(:staff)
    @staff = Staff.new(staff_params)

    if @staff.save
      redirect_to(staffs_path, notice: 'Staff registration successful')
    else
      # Will take care of the format
      respond_with(@staff)
    end
  end

  def edit
  end

  def update
    authorize(:staff)
    binding.pry
    # Remove the password from params so it does not updated if it is blank
    params[:staff].delete(:password) if params[:staff][:password].blank?
    params[:staff].delete(:password_confirmation) if params[:staff][:password_confirmation].blank?

    if @staff.update(staff_params)
      redirect_to(staffs_path, notice: 'Staff update successful')
    else
      # Will take care of the format
      respond_with(@staff)
    end
  end

  private

  def staff_params
    params.require(:staff).permit(:id, :userId, :team_id, :email, :password, :password_confirmation,
                                  person_attributes: [:id, :firstName, :lastName, :gender, :dateOfBirth, :telHomeNo, :telMobileNo,
                                                      address_attributes: [:id, :houseNumber, :street, :town, :postcode]],
                                  specialisms_attributes: [:id, :speciality_id],
                                  jobs_attributes: [:id, :job_title_id])
  end

  def set_staff
    @staff = Staff.find(params[:id])

    # In this situation where staff can only access their profile unless admin
    # The record must be given, that is: @staff
    authorize(@staff)
  end
end