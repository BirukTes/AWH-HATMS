class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Run the configuration before devise controllers
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Parameters for devise
  def configure_permitted_parameters

    # Permitted attributes during registration for staff, person, specialism, job
    devise_parameter_sanitizer.permit(:sign_up, keys: [:userId, :email, :password, :team_id,
                                                       people_attributes: [:firstName, :lastName, :gender, :dateOfBirth,
                                                                           :houseNumber, :street, :town, :postcode, :telNumber, :mobileNumber],
                                                       specialisms_attributes: [:staff_id, :speciality_id],
                                                       jobs_attributes: [:staff_id, :job_title_id]])

    # Permitted attributes during login for staff, person, specialism, job
    devise_parameter_sanitizer.permit(:sign_in, keys: [:userId, :password, :remember_me])


    # Permitted attributes during update for staff, person, specialism, job
    devise_parameter_sanitizer.permit(:account_update, keys: [:userId, :email, :password, :team_id,
                                                              people_attributes: [:firstName, :lastName, :gender, :dateOfBirth,
                                                                                  :houseNumber, :street, :town, :postcode, :telNumber, :mobileNumber],
                                                              specialisms_attributes: [:staff_id, :speciality_id],
                                                              jobs_attributes: [:staff_id, :job_title_id]])
  end
end
