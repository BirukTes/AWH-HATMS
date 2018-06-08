# Handles reports system, to view, create and update
#
# @author Bereketab Gulai
class ReportsController < ApplicationController

  # Run the method before any action
  before_action(:perform_authorise)

  # GET ward list with conditions in params
  # Supports XLSX
  def ward_list
    @search = Admission.admitted.ransack(params[:q])
    @admissions = @search.result.includes(:ward, :patient)

    # Formats: :html, :js, :json, :xlsx
    respond_with(@admissions) do |format|
      format.xlsx do
        render xlsx: 'ward_list', filename: 'Ward List.xlsx', disposition: 'attachment',
               xlsx_created_at: Time.now, xlsx_author: 'AllsWell Hospital'
      end
    end
  end

  # GET medications list with conditions in params
  def medications_list
    @search = Admission.admitted.ransack(params[:q])
    @admissions = @search.result.includes(:ward, :patient)
  end

  # GET discharge list with conditions in params
  # Supports XLSX
  def discharge_list
    @search = Admission.admitted.where.not(dischargeDate: nil).all.ransack(params[:q])
    @admissions = @search.result.includes(:ward, :patient)

    # Formats: :html, :js, :json, :xlsx
    respond_with(@admissions) do |format|
      format.xlsx do
        render xlsx: 'discharge_list', filename: 'Discharge List.xlsx', disposition: 'attachment',
               xlsx_created_at: Time.now, xlsx_author: 'AllsWell Hospital'
      end
    end
  end

  # GET patient card with conditions in params
  def patient_card
    @search = Admission.admitted.ransack(params[:q])
    @admission = @search.result.first if params[:q]
  end

  private

  # Permitted params
  def report_params
    params.require(:report).permit(:from_date, :to_date, :ward_id)
  end

  # Call the authorize method of Pundit with corresponding policy name
  def perform_authorise
    authorize(:report)
  end
end
