# frozen_string_literal: true

class ReportsController < ApplicationController

  # Run the method before any action
  before_action(:perform_authorise)

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

  def medications_list
    @search = Admission.admitted.ransack(params[:q])
    @admissions = @search.result.includes(:ward, :patient)
  end

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

  def patient_card
    @search = Admission.admitted.ransack(params[:q])
    @admission = @search.result.first if params[:q]
  end

  private

  def report_params
    params.require(:report).permit(:from_date, :to_date, :ward_id)
  end

  # Call the authorize method of Pundit with corresponding policy name
  def perform_authorise
    authorize(:report)
  end
end
