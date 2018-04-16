class RegistrationsController < Devise::RegistrationsController

  def new
    @staff = Staff.new
    @staff.build_person
    @staff.specialisms.build_speciality
    @staff.jobs.build_job_title
  end
end