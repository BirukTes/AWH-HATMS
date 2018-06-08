# Handles staff management system, to view, create and update
#
# @author Bereketab Gulai
class StaffsController < ApplicationController
  before_action(:set_staff, only: [:show, :edit, :update])

  # GETs staffs page
  def index
    authorize(:staff)
    @staffs = Staff.all
  end

  # GETs staff profile
  def show
  end

  # GETs registration page
  def new
    authorize(:staff)
    @staff = Staff.new
    @staff.build_person
    @staff.person.build_address
    @staff.specialisms.build
    @staff.jobs.build
  end

  # POSTs registration form to create staff
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

  # GETs edit form
  def edit
  end

  # POST method, uses edit form data to update staff
  def update
    authorize(:staff)

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

  # Permitted params
  def staff_params
    params.require(:staff).permit(:id, :userId, :team_id, :email, :password, :password_confirmation,
                                  person_attributes: [:id, :firstName, :lastName, :gender, :dateOfBirth, :telHomeNo, :telMobileNo,
                                                      address_attributes: [:id, :houseNumber, :street, :town, :postcode]],
                                  specialisms_attributes: [:id, :speciality_id],
                                  jobs_attributes: [:id, :job_title_id])
  end

  # Sets and authorises staff record
  def set_staff
    @staff = Staff.find(params[:id])

    # In this situation where staff can only access their profile unless admin
    # The record must be given, that is: @staff
    authorize(@staff)
  end
end