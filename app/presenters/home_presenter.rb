# @author Bereketab Gulai
# May/2018
#
module HomePresenter

  class IndexPresenter
    def admissions_all_count
      Admission.all.count
    end

    def admissions_admitted
      Admission.admitted.ransack.result.limit(5)
    end

    def admissions_scheduled
      Admission.scheduled.ransack.result.limit(5)
    end

    def admissions_discharged
      Admission.discharged.ransack.result.limit(5)
    end

    def patients_count
      Patient.all.count
    end

    def staffs_count
      Staff.all.count
    end

    def teams_count
      Team.all.count
    end

    def job_titles_count
      JobTitle.all.count
    end

    def specialities_count
      Speciality.all.count
    end

    def wards_count
      Ward.all.count
    end

    def ward_all_beds
      Ward.all.map do |ward|
        ward.numberOfBeds
      end.sum
    end

    def ward_available_beds
      Ward.all.map do |ward|
        ward.bedStatus
      end.sum
    end
  end
end