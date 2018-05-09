class ReportsController < ApplicationController

  respond_to(:html, :js, :json)
  # based on the filter criteria specified for the reports
  def ward_list

    search_by_ward_id = params[:ward_id]
    search_by_from_date = params[:from_date]
    search_by_to_date = params[:to_date]

    if !params[:from_date].blank? && !params[:to_date].blank? && params[:ward_id].blank?
      @admissions = Admission.where('"admissionDate" BETWEEN ? AND ?', search_by_from_date, search_by_to_date)
    elsif !params[:from_date].blank? && !params[:to_date].blank? && !params[:ward_id].blank?
      @admissions = Admission.where('"admissionDate" BETWEEN ? AND ? AND ward_id = ?',
                                    search_by_from_date, search_by_to_date, search_by_ward_id)

    end
    respond_with(@admissions)
    # respond_to do |format|
    #   format.html
    #   format.xls
    #   format.js
    # end
  end

  def medications_list
  end

  def discharge_list
  end

  def patient_card
  end


  private

  def report_params
    params.require(:report).permit(:from_date, :to_date, :ward_id)
  end

end
