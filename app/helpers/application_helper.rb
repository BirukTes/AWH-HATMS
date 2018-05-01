module ApplicationHelper
  def alert_class(flash_type)
    case flash_type.to_sym
      when :notice
        "alert-success"
      when :alert
        "alert-warning"
      when :error
        "alert-danger"
    end
  end

  def speciality_options
    Speciality.all.map do |speciality|
      # Hash [key, value]
      [speciality.speciality, speciality.id]
    end
  end

  def job_title_options
    JobTitle.all.map do |job_title|
      [job_title.title, job_title.id]
    end
  end

  def team_options
    Team.all.map do |team|
      [team.name, team.id]
    end
  end

  def drug_options
    Drug.all.map do |drug|
      [drug.name, drug.id]
    end
  end

  def ward_options(filter_by = nil, patient_gender = nil)
    case filter_by
      when 'admission'
        Ward.admission_options(patient_gender)
      when 'wards_for_current_staff'
        current_staff.team.wards.map do |ward|
          [ward.name, ward.id]
        end
      else
        Ward.all.map do |ward|
          [ward.name, ward.id]
        end
    end
  end

  def all_staffs
    Staff.all.limit(4)
  end

end
