class Search::SearchController < ApplicationController

  def search
    @people_patients = Person.ransack(firstName_or_lastName_cont: params[:q], personalDetail_type_eq: 'Patient').result.limit(5)
    @wards = Ward.ransack(name_cont: params[:q]).result.limit(5)

    respond_to do |format|
      format.json { @people_patients
      @wards }
    end
  end
end