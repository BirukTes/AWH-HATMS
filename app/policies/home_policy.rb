# Defines custom headless policy for home controller actions
#
# @author Bereketab Gulai
class HomePolicy < Struct.new(:staff, :home)

  # Only has one action
  #
  # @return [boolean]
  def index?
    true # all staff
  end
end
