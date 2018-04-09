class SessionsController < Devise::SessionsController
  layout 'login'

  def new
    super
    @staffs = Staff.all
  end
end