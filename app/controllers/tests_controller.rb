class TestsController < ApplicationController
  def index
  end

  def new
    puts(params.key?(:ward_id_selected))
    puts(params[:ward_id_selected])
  end
  def create

  end

  def test_params
    params.require(:test).permit(:ward_id_selected)
  end

end
