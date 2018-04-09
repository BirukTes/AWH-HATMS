class PeopleController < ApplicationController

  def index
    @people = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    @person = person_params[]
  end

  private

  # Only the following attributes are allowed, as a whitelist
  def person_params
    params.require(:people).permit(:firstName, :lastName, :gender, :dateOfBirth,
                                   :houseNumber, :street, :town, :postcode, :telHomeNo, :telMobileNo)
  end
end
