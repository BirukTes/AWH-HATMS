class HomeController < ApplicationController
  def index
    authorize(:home, :index?)
    # The presenter contains all the necessary methods
    # This keeps the scope the methods local to this controller and it is view
    @home_presenter = HomePresenter::IndexPresenter.new
  end
end
