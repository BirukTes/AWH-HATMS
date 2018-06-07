# Provides method to decorate () patient
class PatientDecorator
# Refs: https://www.youtube.com/watch?v=OGdVJj-jNoc

# Reader/get method for the class to be used
  attr_reader :component

  def initialize(component)
    @component = component
  end
end