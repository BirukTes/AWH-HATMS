module DeviseWhitelist
  extend ActiveSupport::Concern

  # Called before any class or method in this module
  included do
    # Run the configuration before devise controllers
    before_action :configure_permitted_parameters, if: :devise_controller?
  end


  def configure_permitted_parameters

    # Permitted attributes during registration for staff, people, specialism, job
    devise_parameter_sanitizer.permit(:sign_up, keys: [:userId, :team_id, :email,
                                                       person_attributes: [:firstName, :lastName, :gender, :dateOfBirth,
                                                                           :houseNumber, :street, :town, :postcode, :telHomeNo, :telMobileNo],
                                                       specialisms_attributes: [:speciality_id],
                                                       jobs_attributes: [:job_title_id]])

    # Permitted attributes during login for staff, people, specialism, job
    devise_parameter_sanitizer.permit(:sign_in, keys: [:userId])


    # Permitted attributes during update for staff, people, specialism, job
    devise_parameter_sanitizer.permit(:account_update, keys: [:userId, :team_id, :email,
                                                              person_attributes: [:firstName, :lastName, :gender, :dateOfBirth,
                                                                                  :houseNumber, :street, :town, :postcode, :telHomeNo, :telMobileNo],
                                                              specialisms_attributes: [:speciality_id],
                                                              jobs_attributes: [:job_title_id]])
  end
end