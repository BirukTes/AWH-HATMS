class WardsController < ApplicationController
  before_action :set_ward, only: [:show, :edit, :update, :destroy]

  # Declaration of formats
  respond_to(:html, :js, :json, :xlsx)

  # GET /wards
  # GET /wards.json
  def index
    authorize(:ward)
    @wards = Ward.all
    respond_with(@wards) do |format|
      format.xlsx { render xlsx: 'index', filename: 'Wards.xlsx', disposition: 'attachment',
                           xlsx_created_at: Time.now, xlsx_author: 'AllsWell Hospital' }
    end
  end

  # GET /wards/1
  # GET /wards/1.json
  def show
  end

  # GET /wards/new
  def new
    authorize(:ward)
    @ward = Ward.new
  end

  # GET /wards/1/edit
  def edit
  end

  # POST /wards
  # POST /wards.json
  def create
    authorize(:ward)
    @ward = Ward.new(ward_params)

    respond_to do |format|
      if @ward.save
        format.html { redirect_to @ward, notice: 'Ward was successfully created.' }
        format.json { render :show, status: :created, location: @ward }
      else
        format.html { render :new }
        format.json { render json: @ward.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wards/1
  # PATCH/PUT /wards/1.json
  def update
    respond_to do |format|
      if @ward.update(ward_params)
        format.html { redirect_to @ward, notice: 'Ward was successfully updated.' }
        format.json { render :show, status: :ok, location: @ward }
      else
        format.html { render :edit }
        format.json { render json: @ward.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wards/1
  # DELETE /wards/1.json
  def destroy
    # Do not destroy, find solution
    # @ward.destroy
    # respond_to do |format|
    #   format.html { redirect_to wards_url, notice: 'Ward was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ward
    authorize(:ward)
    @ward = Ward.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ward_params
    params.require(:ward).permit(:name, :wardNumber, :numberOfBeds, :bedStatus, :patientGender, :deptName, :isPrivate)
  end
end
