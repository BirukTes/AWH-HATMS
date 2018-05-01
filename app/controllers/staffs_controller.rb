class StaffsController < ApplicationController

  def index
    @staffs = Staff.all
  end

  def new
    @staff = Staff.new
    @staff.build_person
    @staff.person.build_address
    @staff.specialisms.build
    @staff.jobs.build
  end

  def create
    @staff = Staff.new(user_params)
    if @staff.save!
      redirect_to(staffs_path, notice: 'Staff registration successful')
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:staff).permit(:id, :userId, :team_id, :email,:password, :password_confirmation,
                                  person_attributes: [:id, :firstName, :lastName, :gender, :dateOfBirth, :telHomeNo, :telMobileNo,
                                                      address_attributes: [:id, :houseNumber, :street, :town, :postcode]],
                                  specialism_attributes: [:speciality_id],
                                  job_attributes: [:job_title_id])
  end
end