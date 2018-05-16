module HomePresenter
  class IndexPresenter
    def admissions
    Admission.ransack.result

    end

    def patients
      Patient.ransack.result
    end

    def staffs
      Staff.ransack.result
    end

    def teams
      Team.ransack.result
    end

    def job_titles
      JobTitle.all.count.to_s
    end

    def specialities
      Speciality.all.count.to_s
    end

    def wards
     Ward.ransack.result
    end

    def ward_all_beds
      Ward.all.map do |ward|
        ward.numberOfBeds
      end.sum.to_s
    end

    def ward_available_beds
      Ward.all.map do |ward|
        ward.bedStatus
      end.sum.to_s
    end
  end
end