class StaffsController < ApplicationController
  # Define the formats
  respond_to(:html, :js)

  before_action(:set_staff, only: [:show])

  # Verify authorisation
  after_action(:verify_authorized)

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
    @staff = Staff.new(user_params)

    if @staff.save!
      redirect_to(staffs_path, notice: 'Staff registration successful')
    else
      # Will take care of the format
      respond_with(@staff)
    end
  end

  private

  def user_params
    params.require(:staff).permit(:id, :userId, :team_id, :email, :password, :password_confirmation,
                                  person_attributes: [:id, :firstName, :lastName, :gender, :dateOfBirth, :telHomeNo, :telMobileNo,
                                                      address_attributes: [:id, :houseNumber, :street, :town, :postcode]],
                                  specialisms_attributes: [:speciality_id],
                                  jobs_attributes: [:job_title_id])
  end

  def set_staff
    @staff = Staff.find(params[:id])

    # In this situation where staff can only access their profile unless admin
    # The record must be given, that is: @staff
    authorize(@staff)
  end
end