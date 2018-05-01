class RegistrationsController < Devise::RegistrationsController

  # skip_before_action(:require_no_authentication, only: [:new])
  skip_before_filter :require_no_authentication, only: [:new]
  def new
    @staff = Staff.new
    @staff.build_person
    @staff.specialisms.build_speciality
    @staff.jobs.build_job_title
  end
end