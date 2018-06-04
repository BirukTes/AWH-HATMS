class Search::SearchController < ApplicationController

  # Returns patients and wards for global search, auto-complete
  def search
    # One is enough for now
    authorize(:patient, :show?)

    @people_patients = Person.ransack(firstName_or_lastName_cont: params[:q], personalDetail_type_eq: 'Patient').result.limit(5)
    @wards = Ward.ransack(name_cont: params[:q]).result.limit(5)

    respond_to do |format|
      format.json { @people_patients
      @wards }
    end
  end
end