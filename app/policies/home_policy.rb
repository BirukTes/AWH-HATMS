# Headless policy
#
class HomePolicy < Struct.new(:staff, :home)

  # Only has one action
  #
  # @return [boolean]
  def index?
    true # all staff
  end
end
