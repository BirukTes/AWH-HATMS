# Handles home page to view all, methods are provided by presenter
#
# @author Bereketab Gulai
class HomeController < ApplicationController
  # Gets home page
  #
  # GET
  def index
    authorize(:home, :index?)
    # The presenter contains all the necessary methods
    # This keeps the scope the methods local to this controller and it is view
    @home_presenter = HomePresenter::IndexPresenter.new
  end
end
