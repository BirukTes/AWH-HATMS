module HomePresenter
  class IndexPresenter
    def admissions
      Admission.all
    end

    def patients
      Patient.all
    end

    def staffs
      Staff.all
    end

    def teams
      Team.all
    end

    def job_titles
      JobTitle.all.count.to_s
    end

    def specialities
      Speciality.all.count.to_s
    end

    def wards
      Ward.all
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